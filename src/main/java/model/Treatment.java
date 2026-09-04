package model;

import java.math.BigDecimal;

public class Treatment {

    private int treatmentId;
    private String treatmentName;
    private BigDecimal treatmentPrice;

    public Treatment() {
    }

    public Treatment(int treatmentId, String treatmentName,
                     BigDecimal treatmentPrice) {

        this.treatmentId = treatmentId;
        this.treatmentName = treatmentName;
        this.treatmentPrice = treatmentPrice;
    }

    public int getTreatmentId() {
        return treatmentId;
    }

    public void setTreatmentId(int treatmentId) {
        this.treatmentId = treatmentId;
    }

    public String getTreatmentName() {
        return treatmentName;
    }

    public void setTreatmentName(String treatmentName) {
        this.treatmentName = treatmentName;
    }

    public BigDecimal getTreatmentPrice() {
        return treatmentPrice;
    }

    public void setTreatmentPrice(BigDecimal treatmentPrice) {
        this.treatmentPrice = treatmentPrice;
    }
}