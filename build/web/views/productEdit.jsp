<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@page import="model.*" %>
<%@page import="database.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin Panel</title>
        <link rel="icon" href="./resources/img/icon.png" type="image/gif" sizes="16x16">
        <link rel="icon" href="./resources/img/icon.png" type="image/gif" sizes="18x18">
        <link rel="icon" href="./resources/img/icon.png" type="image/gif" sizes="20x20">

        <style>
            body {
                font-family: Arial, sans-serif;
                margin: 0;
                padding: 20px;
            }

            h1 {
                text-align: center;
                color: #333;
            }

            h2 {
                text-align: center;
                color: #333;
            }

            form {
                max-width: 400px;
                margin: 20px auto;
                padding: 20px;
                background-color: #fff;
                border-radius: 5px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            }

            .form-group {
                display: flex;
                align-items: center;
                justify-content: space-between;
                margin-bottom: 10px;
            }

            label {
                color: #333;
                font-weight: bold;
                margin-right: 10px;
            }

            input[type="text"] {
                flex: 1;
                padding: 8px;
                border: 1px solid #ccc;
                border-radius: 4px;
            }

            .product-description {
                flex: 1;
                padding: 8px;
                border: 1px solid #ccc;
                border-radius: 4px;
            }

            input[type="Date"] {
                flex: 1;
                padding: 8px;
                border: 1px solid #ccc;
                border-radius: 4px;
            }

            input[type="submit"] {
                display: block;
                width: 100%;
                padding: 8px;
                margin-top: 10px;
                background-color: #4caf50;
                color: #fff;
                border: none;
                border-radius: 4px;
                cursor: pointer;
            }

            button {
                display: block;
                margin: 10px auto;
                padding: 8px 16px;
                background-color: #ccc;
                color: #333;
                border: none;
                border-radius: 4px;
                cursor: pointer;
            }

            button:hover, input[type="submit"]:hover {
                background-color: #333;
                color: #fff;
            }
        </style>
    </head>

    <body>
        <%
            ProductDAO p = new ProductDAO();
            Product product = (Product) request.getAttribute("product");
            String[] cols = (String[]) p.getColNames("Product");
            String error = (String) request.getAttribute("error");
            if (product == null) return;
        %>  
        <h1>Admin Panel</h1>

        <jsp:include page="adminnavbar.jsp" />

        <h2>Update a product</h2>
        <form action="updateProduct" method="POST">
            <% for (String col : cols) {
    if (col.equals("product_id")) { %>
            <div class="form-group">
                <label><%=col%></label>
                <input type="text" name="<%=col%>" value="<%=product.getProductID()%>" readonly />
            </div>
            <%} if (col.equals("product_description")) { %> 
            <div class="form-group">
                <label><%=col%></label>
                <textarea class="product-description" name="<%=col%>" rows="10" cols="20" style="overflow-y:scroll;"><%= p.getProductInformation(Integer.toString(product.getProductID()), col) %></textarea>
            </div>
            <%} else { %>
            <div class="form-group">
                <label><%=col%></label>
                <input type="text" name="<%=col%>" value="<%= p.getProductInformation(Integer.toString(product.getProductID()), col) %>"/>
            </div>
            <% }
        }
            %>

            <div class="error" style="color:red;">
                <p> <%=((error == null) ? "" : error)%>
            </div>
            <input type="submit" value="Update">
        </form>  
    </body>
</html>
