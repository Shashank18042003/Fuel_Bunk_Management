package com.example.demo.util;


public class FuelStatusUtil {

    public static String getFuelStatus(
            double availableLiters) {

        if(availableLiters <= 0) {

            return "OUT OF STOCK";
        }

        else if(availableLiters < 1000) {

            return "LOW";
        }

        return "AVAILABLE";
    }
}