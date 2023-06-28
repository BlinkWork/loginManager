/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import static controller.CartServlet.parseCarts;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.*;
import controller.*;
import database.ProductDAO;
import database.UserDAO;
import jakarta.servlet.http.HttpSession;
import java.text.DecimalFormat;

/**
 *
 * @author USER
 */
@WebServlet(name = "CheckoutServlet", urlPatterns = {"/checkout"})
public class CheckoutServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String userName = (String) session.getAttribute("username");
        if (userName != null) {
            UserDAO udao = new UserDAO();
            String user_id = String.valueOf(udao.getUserByUsername(userName).getId());
            CartServlet sessionHandle = new CartServlet();
            String cartItems = sessionHandle.getCartSession(request, response, user_id);
            ProductDAO dao = new ProductDAO();
            String data = "";
            if (cartItems != null) {
                List<Cart> listCartId = parseCarts(cartItems);
                for (Cart cart : listCartId) {
                    Product p = dao.getProductByID(cart.getProduct_id());
                    DecimalFormat df = new DecimalFormat("#.##");
                    double price = p.getPrice() * (100 - p.getDiscount()) / 100;
                    String formattedPrice = df.format(price);
                    double amount = price * cart.getQuantity();
                    String formattedAmount = "$" + df.format(amount);

                    data += dao.getProductByID(cart.getProduct_id()).getProductName() + "_" + cart.getQuantity() + "_" + formattedAmount + "@";

                }
            }

            request.setAttribute("dataCart", data);
            RequestDispatcher rd = request.getRequestDispatcher("./views/checkout.jsp");
            rd.forward(request, response);
        }

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

}
