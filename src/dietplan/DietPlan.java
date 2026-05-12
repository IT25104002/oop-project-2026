package dietplan;

public class DietPlan {
    private int planId;
    private int memberId;
    private String memberName;
    private String dietType;
    private String fitnessGoal;
    private String medicalCondition;
    private double waterIntake;
    private String planDetails;
    private String createdDate;

    public DietPlan(int planId, int memberId, String memberName, String dietType,
                    String fitnessGoal, String medicalCondition, double waterIntake,
                    String planDetails, String createdDate) {
        this.planId = planId;
        this.memberId = memberId;
        this.memberName = memberName;
        this.dietType = dietType;
        this.fitnessGoal = fitnessGoal;
        this.medicalCondition = medicalCondition;
        this.waterIntake = waterIntake;
        this.planDetails = planDetails;
        this.createdDate = createdDate;
    }

    public int getPlanId() { return planId; }
    public void setPlanId(int planId) { this.planId = planId; }
    public int getMemberId() { return memberId; }
    public void setMemberId(int memberId) { this.memberId = memberId; }
    public String getMemberName() { return memberName; }
    public void setMemberName(String memberName) { this.memberName = memberName; }
    public String getDietType() { return dietType; }
    public void setDietType(String dietType) { this.dietType = dietType; }
    public String getFitnessGoal() { return fitnessGoal; }
    public void setFitnessGoal(String fitnessGoal) { this.fitnessGoal = fitnessGoal; }
    public String getMedicalCondition() { return medicalCondition; }
    public void setMedicalCondition(String medicalCondition) { this.medicalCondition = medicalCondition; }
    public double getWaterIntake() { return waterIntake; }
    public void setWaterIntake(double waterIntake) { this.waterIntake = waterIntake; }
    public String getPlanDetails() { return planDetails; }
    public void setPlanDetails(String planDetails) { this.planDetails = planDetails; }
    public String getCreatedDate() { return createdDate; }
    public void setCreatedDate(String createdDate) { this.createdDate = createdDate; }

    public String toFileLine() {
        return planId + "|" + memberId + "|" + memberName + "|" + dietType + "|" +
                fitnessGoal + "|" + medicalCondition + "|" + waterIntake + "|" +
                planDetails.replace("\n", "~~") + "|" + createdDate;
    }

    public static DietPlan fromFileLine(String line) {
        String[] p = line.split("\\|");
        if (p.length < 9) return null;
        return new DietPlan(
                Integer.parseInt(p[0]), Integer.parseInt(p[1]), p[2], p[3], p[4], p[5],
                Double.parseDouble(p[6]), p[7].replace("~~", "\n"), p[8]
        );
    }
}