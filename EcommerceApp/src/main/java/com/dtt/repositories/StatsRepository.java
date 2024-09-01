/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.dtt.repositories;

import java.util.List;

/**
 *
 * @author THIEN TU
 */
public interface StatsRepository {
    List<Object[]> statsRevenueByProduct();
    List<Object[]> statsRevenueByPeriod(int year, String period);
}
