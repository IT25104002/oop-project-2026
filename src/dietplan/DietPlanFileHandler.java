package dietplan;

import java.io.*;
import java.util.*;

public class DietPlanFileHandler {

    private static final String FILE_PATH = System.getProperty("catalina.home") +
            File.separator + "webapps" + File.separator + "gymapp" + File.separator + "diet_plans.txt";

    public boolean createDietPlan(DietPlan plan) {
        plan.setPlanId(getNextId());
        try (BufferedWriter bw = new BufferedWriter(new FileWriter(FILE_PATH, true))) {
            bw.write(plan.toFileLine());
            bw.newLine();
            return true;
        } catch (IOException e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<DietPlan> getAllDietPlans() {
        List<DietPlan> plans = new ArrayList<>();
        File file = new File(FILE_PATH);
        if (!file.exists()) return plans;
        try (BufferedReader br = new BufferedReader(new FileReader(FILE_PATH))) {
            String line;
            while ((line = br.readLine()) != null) {
                if (!line.trim().isEmpty()) {
                    DietPlan dp = DietPlan.fromFileLine(line);
                    if (dp != null) plans.add(dp);
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return plans;
    }

    public DietPlan getDietPlanById(int planId) {
        return getAllDietPlans().stream()
                .filter(p -> p.getPlanId() == planId)
                .findFirst().orElse(null);
    }

    public List<DietPlan> getDietPlansByMemberId(int memberId) {
        List<DietPlan> result = new ArrayList<>();
        for (DietPlan dp : getAllDietPlans()) {
            if (dp.getMemberId() == memberId) result.add(dp);
        }
        return result;
    }

    public boolean updateDietPlan(DietPlan updatedPlan) {
        List<DietPlan> plans = getAllDietPlans();
        boolean found = false;
        for (int i = 0; i < plans.size(); i++) {
            if (plans.get(i).getPlanId() == updatedPlan.getPlanId()) {
                plans.set(i, updatedPlan);
                found = true;
                break;
            }
        }
        return found && writeAllToFile(plans);
    }

    public boolean deleteDietPlan(int planId) {
        List<DietPlan> plans = getAllDietPlans();
        if (plans.removeIf(dp -> dp.getPlanId() == planId)) {
            return writeAllToFile(plans);
        }
        return false;
    }

    private boolean writeAllToFile(List<DietPlan> plans) {
        try (BufferedWriter bw = new BufferedWriter(new FileWriter(FILE_PATH, false))) {
            for (DietPlan dp : plans) {
                bw.write(dp.toFileLine());
                bw.newLine();
            }
            return true;
        } catch (IOException e) {
            e.printStackTrace();
            return false;
        }
    }

    private int getNextId() {
        return getAllDietPlans().stream()
                .mapToInt(DietPlan::getPlanId)
                .max().orElse(0) + 1;
    }

    public static String generatePlanDetails(String dietType, String fitnessGoal, String activityLevel, String medicalStatus) {

        if ("YES".equalsIgnoreCase(medicalStatus)) {
            return "MEDICAL DIET PLAN:\n" +
                    "- Consult your doctor before following this plan\n" +
                    "- Breakfast: Oats with low-fat milk + fruits\n" +
                    "- Mid-Morning: Herbal tea + 2 digestive biscuits\n" +
                    "- Lunch: Brown rice + steamed vegetables + dal\n" +
                    "- Evening Snack: Fresh fruit juice (no sugar)\n" +
                    "- Dinner: Vegetable soup + whole wheat bread\n" +
                    "- Avoid: High sugar, high salt, processed foods";
        }

        boolean isVeg = "vegetarian".equalsIgnoreCase(dietType);

        switch (fitnessGoal.toLowerCase()) {
            case "weight loss":
                if (isVeg) {
                    return "VEGETARIAN WEIGHT LOSS PLAN:\n" +
                            "- Breakfast: Oats porridge + green tea\n" +
                            "- Mid-Morning: 1 apple or cucumber slices\n" +
                            "- Lunch: Brown rice + dal + salad\n" +
                            "- Evening Snack: Roasted chana or sprouts\n" +
                            "- Dinner: Grilled vegetables + roti\n" +
                            "- Avoid: Sugar, fried food, white rice\n" +
                            (activityLevel.equalsIgnoreCase("high") ? "- Extra: Add 45 min cardio daily" : "- Extra: Add 30 min walk daily");
                } else {
                    return "NON-VEGETARIAN WEIGHT LOSS PLAN:\n" +
                            "- Breakfast: Boiled eggs (2) + whole wheat toast\n" +
                            "- Mid-Morning: Greek yogurt\n" +
                            "- Lunch: Grilled chicken breast + brown rice + salad\n" +
                            "- Evening Snack: Boiled egg or tuna\n" +
                            "- Dinner: Grilled fish + steamed vegetables\n" +
                            "- Avoid: Fried chicken, red meat, sugary drinks\n" +
                            (activityLevel.equalsIgnoreCase("high") ? "- Extra: Add 45 min cardio daily" : "- Extra: Add 30 min walk daily");
                }

            case "weight gain":
                if (isVeg) {
                    return "VEGETARIAN WEIGHT GAIN PLAN:\n" +
                            "- Breakfast: Banana smoothie + peanut butter toast + milk\n" +
                            "- Mid-Morning: Mixed nuts + dry fruits\n" +
                            "- Lunch: White rice + paneer curry + roti\n" +
                            "- Evening Snack: Peanut butter + whole wheat bread\n" +
                            "- Dinner: Dal + rice + ghee + vegetables\n" +
                            "- Before Bed: Full-fat milk with banana\n" +
                            (activityLevel.equalsIgnoreCase("high") ? "- Extra: Focus on strength training" : "- Extra: Light resistance training 3x/week");
                } else {
                    return "NON-VEGETARIAN WEIGHT GAIN PLAN:\n" +
                            "- Breakfast: 3 eggs omelette + whole wheat toast + milk\n" +
                            "- Mid-Morning: Chicken sandwich + banana\n" +
                            "- Lunch: White rice + chicken curry + roti\n" +
                            "- Evening Snack: Boiled eggs + peanut butter\n" +
                            "- Dinner: Mutton or fish curry + rice + vegetables\n" +
                            "- Before Bed: Protein shake or full-fat milk\n" +
                            (activityLevel.equalsIgnoreCase("high") ? "- Extra: Focus on strength training" : "- Extra: Light resistance training 3x/week");
                }

            case "maintain":
            default:
                if (isVeg) {
                    return "VEGETARIAN MAINTENANCE PLAN:\n" +
                            "- Breakfast: Idli / dosa + sambar + fruits\n" +
                            "- Mid-Morning: Buttermilk or coconut water\n" +
                            "- Lunch: Rice + dal + sabzi + curd\n" +
                            "- Evening Snack: Fruit salad or roasted snacks\n" +
                            "- Dinner: Roti + mixed vegetable curry\n" +
                            "- Stay consistent with meal timings\n" +
                            (activityLevel.equalsIgnoreCase("high") ? "- Extra: Mix cardio + strength training" : "- Extra: 20-30 min daily activity");
                } else {
                    return "NON-VEGETARIAN MAINTENANCE PLAN:\n" +
                            "- Breakfast: Eggs + toast + orange juice\n" +
                            "- Mid-Morning: Yogurt + nuts\n" +
                            "- Lunch: Rice + fish or chicken curry + salad\n" +
                            "- Evening Snack: Boiled egg or fruit\n" +
                            "- Dinner: Grilled chicken or fish + roti + vegetables\n" +
                            "- Stay consistent with meal timings\n" +
                            (activityLevel.equalsIgnoreCase("high") ? "- Extra: Mix cardio + strength training" : "- Extra: 20-30 min daily activity");
                }
        }
    }
}