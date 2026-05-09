package com.fitnaze.demo;

public class Payment {
    private String name;
    private String plan;
    private int duration;
    private double amount;
    private String paymentMethod;
    private String status; // මේක තමයි getStatus() එකට ඕන කරන්නේ

    // Default Constructor (Spring Boot එකට අනිවාර්යයි)
    public Payment() {}

    // Getters and Setters
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getPlan() { return plan; }
    public void setPlan(String plan) { this.plan = plan; }

    public int getDuration() { return duration; }
    public void setDuration(int duration) { this.duration = duration; }

    public double getAmount() { return amount; }
    public void setAmount(double amount) { this.amount = amount; }

    public String getPaymentMethod() { return paymentMethod; }
    public void setPaymentMethod(String paymentMethod) { this.paymentMethod = paymentMethod; }

    public String getStatus() { return status; } // මේ Getter එක තමයි Controller එක හොයන්නේ
    public void setStatus(String status) { this.status = status; }
}