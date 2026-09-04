package service;

import dao.ReportDAO;

public class ReportService {

    private final ReportDAO reportDAO;

    public ReportService() {
        reportDAO = new ReportDAO();
    }

    public int getTotalAppointments() {
        return reportDAO.getTotalAppointments();
    }

    public int getPendingAppointments() {
        return reportDAO.getPendingAppointments();
    }

    public int getCompletedAppointments() {
        return reportDAO.getCompletedAppointments();
    }

    public int getCancelledAppointments() {
        return reportDAO.getCancelledAppointments();
    }
}