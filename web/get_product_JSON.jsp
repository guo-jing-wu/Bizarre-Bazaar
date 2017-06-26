<%@page contentType="text/html" pageEncoding="UTF-8"%> 

<%@page language="java" import="dbUtils.DbConn" %>
<%@page language="java" import="model.Product.StringData" %>
<%@page language="java" import="model.Product.ProductMods" %>

<%
            String productId = request.getParameter("primaryKey");
            StringData wuStringData = new StringData();// all properties empty
           // Validate wuValidate = new Validate(); // all error messages empty
            DbConn dbc = new DbConn();  // get an OPEN db connection. 
            String dbError = dbc.getErr();
            if (dbError.length() != 0) { // could not get connection
                wuStringData.setRecordStatus("Database connection error in getProduct.jsp: " + dbError); 
            } else { // got connection
                ProductMods sqlMods = new ProductMods(dbc);
                wuStringData = sqlMods.findKey(productId);
                if (wuStringData == null) {
                    wuStringData.setRecordStatus("get_product_JSON.jsp. Problem finding record with id "+productId+": " + sqlMods.getErrorMsg());
                } else {
                    wuStringData.setRecordStatus ("If found, fields have values. If not found, all fields are empty string."); // wu.toString(); 
                }
            }
            out.print(wuStringData.toJSON());
            dbc.close();
%>
