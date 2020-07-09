/// RESTful web services handler for "IRIS Coffee Company" tutorial
Class ICO.Handler Extends %CSP.REST
{

Parameter HandleCorsRequest = 1;

Parameter CONTENTTYPE = "application/json";

ClassMethod GetJSONFromRequest(Output obj As %DynamicObject) As %Boolean
{
    set ok = 1
    try {
        set obj = ##class(%DynamicObject).%FromJSON(%request.Content)
    } catch ex {
        set ok = 0
    }
    Quit ok
}

/// Query the inventory using a particular inventory ID for raw beans that can be roasted
ClassMethod ListRawBean(id As %String) As %Status
{
    try {
        if (1 '= ##class(ICO.inventory).%ExistsId(id))
        {
            set err = {}
            set err."error" = "ID "_id_" does NOT exist!"
            write err.%ToJSON()
        }
        else 
        {
            set item = ##class(ICO.inventory).%OpenId(id)
            do item.%JSONExportToString(.outstring)
            write outstring
        }
    } catch (oException) {
        set expobj = {}
        set expobj."exception" = oException.%AsSystemError()
        write expobj.%ToJSON()
    }
    Quit $$$OK
}

/// Query the inventory for all raw beans in inventory that can be roasted
ClassMethod ListRawBeans() As %Status
{
    try {
        set sqlquery = "SELECT ID, vendor_product_code, date_arrival, SUM(quantity_kg) AS quantity_kg FROM ICO.inventory GROUP BY vendor_product_code ORDER BY date_arrival"
        set rs = ##class(%SQL.Statement).%ExecDirect(,sqlquery)
        set itemsarray = []

        while rs.%Next()
        {
            do itemsarray.%Push(
                {
                    "id": (rs.%Get("ID")),
                    "vendor_product_code": (rs.%Get("vendor_product_code")), 
                    "date_arrival": (rs.%Get("date_arrival")), 
                    "quantity_kg": (rs.%Get("quantity_kg"))
                }
            )
        }
        set itemsobj = {}
        set itemsobj."rowcount" = rs.%ROWCOUNT
        set itemsobj."items" = itemsarray
        write itemsobj.%ToJSON()
    } catch (oException) {
        set expobj = {}
        set expobj."exception" = oException
        write expobj.%ToJSON()
    }
    Quit $$$OK
}

/// Take a specific item and amount out of inventory for roasting
/// <br><b>id: </b>inventory ID
/// <br><b>quantity: </b>amount in kilograms
ClassMethod GetRawBeans(id As %String, quantity As %Numeric) As %Status
{
    try {
        if (1 '= ##class(ICO.inventory).%ExistsId(id))
        {
            set err = {}
            set err."error" = "ID "_id_" does NOT exist!"
            write err.%ToJSON()
        }
        else 
        {
            set item = ##class(ICO.inventory).%OpenId(id)
            if (quantity > item.quantitykg)
            {
                set err = {}
                set err."error" = "You tried to get "_quantity_", but we only have "_item.quantitykg_" kilograms available."
                write err.%ToJSON()
            }
            else 
            {
                set item.quantitykg = (item.quantitykg - quantity)
                set sc = item.%Save()
                do item.%JSONExportToString(.outstring)
                write outstring
            }
        }
    } catch (oException) {
        set expobj = {}
        set expobj."exception" = oException.%AsSystemError()
        write expobj.%ToJSON()
    }
    Quit $$$OK
}

/// Put newly roasted product into the catalog
/// POST request with a JSON body. Example body:
/// <EXAMPLE>
/// {
///   "product_code": "BRAZILDARK",
///   "quantity": 20,
///   "time_roasted": "2020-05-24T09:00:00",
///   "roasting_notes": "Full bodied and low acidity. Thick, creamy, nutty and semi-sweet."
/// }
/// </EXAMPLE>
ClassMethod CatalogProduct() As %Status
{
    if '..GetJSONFromRequest(.obj) {
        set %response.Status = ..#HTTP400BADREQUEST
        set error = {"error": "No JSON body in request"}
        write error.%ToJSON()
        Quit $$$OK
    }

    try {
        set catobj = ##class(ICO.catalog).%New()
        set catobj.productcode = obj."product_code"
        set catobj.quantity = obj."quantity"
        set catobj.price = obj."price"
        set catobj.timeroasted = obj."time_roasted"
        set catobj.roastingnotes = obj."roasting_notes"
        set catobj.img = obj."img"
        set sc = catobj.%Save()
        set resp = {}
        set resp."success" = 1
        write resp.%ToJSON()
    } catch (oException) {
        set expobj = {}
        set expobj."exception" = oException.%AsSystemError()
        write expobj.%ToJSON()
    }
    Quit $$$OK
}

/// Get products and be able to filter by ID and type (product code)
/// <br><b>maxdaysold: </b>only return products roasted no later than this number of days ago
ClassMethod GetProducts(fresh As %Boolean = 1) As %Status
{
    try {
        set sqlquery = "SELECT catalog_id, product_code, quantity, price, time_roasted, roasting_notes, img FROM ICO.catalog"
        if fresh = 1 {
            set sqlquery = sqlquery_" WHERE time_roasted > DATEADD('day',-?,CURRENT_DATE)"
        } else {
            set sqlquery = sqlquery_" WHERE time_roasted <= DATEADD('day',-?,CURRENT_DATE)"
        }
        set rs = ##class(%SQL.Statement).%ExecDirect(,sqlquery, 5)
        #; write sqlquery
        set itemsarray = []

        while rs.%Next()
        {
            do itemsarray.%Push(
                {
                    "catalog_id": (rs.%Get("catalog_id")),
                    "product_code": (rs.%Get("product_code")), 
                    "quantity": (rs.%Get("quantity")),
                    "time_roasted": (rs.%Get("time_roasted")),
                    "roasting_notes": (rs.%Get("roasting_notes")),
                    "img": (rs.%Get("img")),
                    "price": (rs.%Get("price"))
                }
            )
        }
        set itemsobj = {}
        set itemsobj."rowcount" = rs.%ROWCOUNT
        set itemsobj."products" = itemsarray
        write itemsobj.%ToJSON()
    } catch (oException) {
        set expobj = {}
        set expobj."exception" = oException
        write expobj.%ToJSON()
    }
    Quit $$$OK
}

/// Decrement the catalog’s stock after a sale
/// <br><b>id: </b>catalog ID
/// <br><b>quantity: </b>amount in kilograms
ClassMethod SellProduct(id As %String, quantity As %Numeric) As %Status
{
    try {
        if (1 '= ##class(ICO.catalog).%ExistsId(id))
        {
            set err = {}
            set err."error" = "Catalog ID "_id_" does NOT exist!"
            write err.%ToJSON()
        }
        else 
        {
            set item = ##class(ICO.catalog).%OpenId(id)
            if (quantity > item.quantity)
            {
                set err = {}
                set err."error" = "You tried to get "_quantity_" bags, but we only have "_item.quantity_" available."
                write err.%ToJSON()
            }
            else 
            {
                set item.quantity = (item.quantity - quantity)
                do item.%JSONExportToString(.outstring)
                write outstring
                set sc = item.%Save()
            }
        }
    } catch (oException) {
        set expobj = {}
        set expobj."exception" = oException.%AsSystemError()
        write expobj.%ToJSON()
    }
    Quit $$$OK
}

XData UrlMap [ XMLNamespace = "http://www.intersystems.com/urlmap" ]
{
<Routes>
        <Route Url="/inventory/listbeans" Method="GET" Call="ListRawBeans" />
        <Route Url="/inventory/listbeans/:id" Method="GET" Call="ListRawBean" />
        <Route Url="/inventory/getbeans/:id/:quantity" Method="POST" Call="GetRawBeans" />
        <Route Url="/catalog/catalogproduct" Method="POST" Call="CatalogProduct" />
        <Route Url="/catalog/getproducts" Method="GET" Call="GetProducts" />
        <Route Url="/catalog/getproducts/:fresh" Method="GET" Call="GetProducts" />
        <Route Url="/catalog/sellproduct/:id/:quantity" Method="POST" Call="SellProduct" />
</Routes>
}

}
