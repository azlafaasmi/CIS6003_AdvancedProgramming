package service;

import java.math.BigDecimal;

import dao.RevenueReportDAO;

public class RevenueReportService {

    private final RevenueReportDAO revenueReportDAO;

    public RevenueReportService() {
        revenueReportDAO = new RevenueReportDAO();
    }

    public int getTotalBills() {
        return revenueReportDAO.getTotalBills();
    }

    public int getPaidBills() {
        return revenueReportDAO.getPaidBills();
    }

    public int getUnpaidBills() {
        return revenueReportDAO.getUnpaidBills();
    }

    public BigDecimal getTotalRevenue() {
        return revenueReportDAO.getTotalRevenue();
    }

    public BigDecimal getPaidRevenue() {
        return revenueReportDAO.getPaidRevenue();
    }

    public BigDecimal getUnpaidRevenue() {
        return revenueReportDAO.getUnpaidRevenue();
    }
}