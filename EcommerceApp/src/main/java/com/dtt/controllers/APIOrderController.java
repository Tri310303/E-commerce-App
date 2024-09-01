/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.dtt.controllers;

import com.braintreepayments.http.HttpResponse;
import com.dtt.pojo.Order;
import com.dtt.services.OrderService;
import com.paypal.api.payments.Amount;
import com.paypal.api.payments.Links;
import com.paypal.api.payments.Payer;
import com.paypal.api.payments.Payment;
import com.paypal.api.payments.PaymentExecution;
import com.paypal.api.payments.RedirectUrls;
import com.paypal.api.payments.Transaction;
import com.paypal.base.rest.APIContext;
import com.paypal.base.rest.PayPalRESTException;
import com.paypal.core.PayPalEnvironment;
import com.paypal.core.PayPalHttpClient;
import com.paypal.orders.AmountWithBreakdown;
import com.paypal.orders.OrderRequest;
import com.paypal.orders.OrdersCreateRequest;
import com.paypal.orders.PurchaseUnitRequest;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

/**
 *
 * @author asus
 */
@RestController
@RequestMapping("/api/payment")
@CrossOrigin

public class APIOrderController {

    @Autowired
    private APIContext apiContext;

    @PostMapping("/pay")
    public ResponseEntity<String> makePayment(@RequestBody Order paymentRequest) {
        try {
            Amount amount = new Amount();
            amount.setCurrency("USD");
            amount.setTotal(paymentRequest.getAmount());

            Transaction transaction = new Transaction();
            transaction.setDescription(paymentRequest.getDescription());
            transaction.setAmount(amount);

            List<Transaction> transactions = new ArrayList<>();
            transactions.add(transaction);

            Payer payer = new Payer();
            payer.setPaymentMethod("paypal");

            Payment payment = new Payment();
            payment.setIntent("sale");
            payment.setPayer(payer);
            payment.setTransactions(transactions);

            RedirectUrls redirectUrls = new RedirectUrls();
            redirectUrls.setCancelUrl("http://localhost:3000/payment");
            redirectUrls.setReturnUrl("http://localhost:3000/payment"); // Chỉnh sửa URL chuyển hướng về ứng dụng của bạn
            payment.setRedirectUrls(redirectUrls);

            Payment createdPayment = payment.create(apiContext);

            for (Links links : createdPayment.getLinks()) {
                if (links.getRel().equals("approval_url")) {
                    return ResponseEntity.ok(links.getHref());
                }
            }

            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("No approval_url found in PayPal response");
        } catch (PayPalRESTException e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("PayPal error: " + e.getMessage());
        }
    }

     @GetMapping("/confirm")
    public ResponseEntity<String> confirmPayment(@RequestParam("paymentId") String paymentId,
            @RequestParam("PayerID") String payerId) {
        try {
            Payment payment = new Payment();
            payment.setId(paymentId);

            PaymentExecution paymentExecution = new PaymentExecution();
            paymentExecution.setPayerId(payerId);

            Payment executedPayment = payment.execute(apiContext, paymentExecution);
            if (executedPayment.getState().equals("approved")) {
                // Xử lý thanh toán thành công và trả về thông báo
                return ResponseEntity.ok("Payment successful");
            } else {
                // Xử lý thanh toán không thành công và trả về thông báo
                return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Payment not approved");
            }
        } catch (PayPalRESTException e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("PayPal error: " + e.getMessage());
        }
    }

    @GetMapping("/cancel")
    public ResponseEntity<String> cancelPayment() {
        return ResponseEntity.ok("Payment canceled");
    }
}
