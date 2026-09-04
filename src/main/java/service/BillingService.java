package service;

import dao.BillDAO;
import model.Bill;

import java.math.BigDecimal;
import java.util.List;

public class BillingService {

    private final BillDAO billDAO;

    private static final BigDecimal CONSULTATION_FEE =
            new BigDecimal("1000.00");

    public BillingService() {
        billDAO = new BillDAO();
    }

    /**
     * Generate a new bill for an appointment.
     *
     * Consultation fee is fixed at Rs. 1000.00.
     * Treatment fee is supplied by the caller.
     */
    public boolean generateBill(
            int appointmentId,
            BigDecimal treatmentFee) {

        if (appointmentId <= 0) {
            return false;
        }

        if (treatmentFee == null ||
                treatmentFee.compareTo(BigDecimal.ZERO) < 0) {
            return false;
        }

        // Prevent duplicate bills for the same appointment.
        if (billDAO.billExistsForAppointment(appointmentId)) {
            return false;
        }

        BigDecimal totalAmount =
                CONSULTATION_FEE.add(treatmentFee);

        Bill bill = new Bill();

        bill.setAppointmentId(appointmentId);
        bill.setConsultationFee(CONSULTATION_FEE);
        bill.setTreatmentFee(treatmentFee);
        bill.setTotalAmount(totalAmount);
        bill.setPaymentStatus("UNPAID");

        return billDAO.addBill(bill);
    }

    /**
     * Get all bills.
     */
    public List<Bill> getAllBills() {
        return billDAO.getAllBills();
    }

    /**
     * Get bill by ID.
     */
    public Bill getBillById(int billId) {

        if (billId <= 0) {
            return null;
        }

        return billDAO.getBillById(billId);
    }

    /**
     * Get bill by appointment ID.
     */
    public Bill getBillByAppointmentId(int appointmentId) {

        if (appointmentId <= 0) {
            return null;
        }

        return billDAO.getBillByAppointmentId(appointmentId);
    }

    /**
     * Update payment status.
     */
    public boolean updatePaymentStatus(
            int billId,
            String paymentStatus) {

        if (billId <= 0 || paymentStatus == null) {
            return false;
        }

        if (!paymentStatus.equals("UNPAID") &&
                !paymentStatus.equals("PAID")) {
            return false;
        }

        return billDAO.updatePaymentStatus(
                billId,
                paymentStatus
        );
    }

    /**
     * Mark a bill as PAID.
     */
    public boolean markAsPaid(int billId) {

        return updatePaymentStatus(
                billId,
                "PAID"
        );
    }

    /**
     * Mark a bill as UNPAID.
     */
    public boolean markAsUnpaid(int billId) {

        return updatePaymentStatus(
                billId,
                "UNPAID"
        );
    }

    /**
     * Delete a bill.
     */
    public boolean deleteBill(int billId) {

        if (billId <= 0) {
            return false;
        }

        return billDAO.deleteBill(billId);
    }

    /**
     * Check whether a bill already exists
     * for an appointment.
     */
    public boolean billExistsForAppointment(
            int appointmentId) {

        if (appointmentId <= 0) {
            return false;
        }

        return billDAO.billExistsForAppointment(
                appointmentId
        );
    }

    /**
     * Get the fixed consultation fee.
     */
    public BigDecimal getConsultationFee() {
        return CONSULTATION_FEE;
    }
}