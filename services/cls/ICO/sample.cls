Class ICO.Handler_SAMPLE Extends %CSP.REST
{

Parameter HandleCorsRequest = 1;

Parameter CONTENTTYPE = "application/json";

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

XData UrlMap [ XMLNamespace = "http://www.intersystems.com/urlmap" ]
{
<Routes>
        <Route Url="/inventory/listbeans" Method="GET" Call="ListRawBeans" />
</Routes>
}

}
