package dietplan;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;

public class DietPlanServlet extends HttpServlet {
    private final DietPlanFileHandler fileHandler = new DietPlanFileHandler();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        HttpSession session = request.getSession(true);

        // -------------------------------------------------------
        // TEMPORARY TEST URLS - teammates will replace with login
        // Admin:  /dietplan?action=list&test=admin
        // Member: /dietplan?action=list&test=member
        // -------------------------------------------------------
        String testRole = request.getParameter("test");
        if ("admin".equals(testRole)) {
            session.setAttribute("role", "admin");
            session.setAttribute("memberId", 0);
            session.setAttribute("memberName", "Admin");
        } else if ("member".equals(testRole)) {
            session.setAttribute("role", "member");
            session.setAttribute("memberId", 1);
            session.setAttribute("memberName", "Test Member");
        }

        // -------------------------------------------------------
        // REAL LOGIN INTEGRATION POINT
        // When teammates connect login, they will set:
        //   session.setAttribute("role", "admin") or "member"
        //   session.setAttribute("memberId", memberId)
        //   session.setAttribute("memberName", memberName)
        // -------------------------------------------------------

        // Check if session is valid
        if (session.getAttribute("role") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String role = (String) session.getAttribute("role");
        String action = request.getParameter("action");
        if (action == null) action = "list";

        if ("admin".equalsIgnoreCase(role)) {
            // ADMIN ROUTES
            if ("view".equals(action)) {
                request.setAttribute("plan", fileHandler.getDietPlanById(
                        Integer.parseInt(request.getParameter("id"))));
                request.setAttribute("action", "view");
                request.setAttribute("plans", fileHandler.getAllDietPlans());
                request.getRequestDispatcher("dietplan.jsp").forward(request, response);
                return;
            } else if ("delete".equals(action)) {
                fileHandler.deleteDietPlan(Integer.parseInt(request.getParameter("id")));
                response.sendRedirect("dietplan?action=list&test=admin");
                return;
            } else if ("edit".equals(action)) {
                request.setAttribute("plan", fileHandler.getDietPlanById(
                        Integer.parseInt(request.getParameter("id"))));
                request.setAttribute("action", "edit");
                request.setAttribute("plans", fileHandler.getAllDietPlans());
                request.getRequestDispatcher("dietplan.jsp").forward(request, response);
                return;
            }
            request.setAttribute("plans", fileHandler.getAllDietPlans());
            request.getRequestDispatcher("dietplan.jsp").forward(request, response);

        } else {
            // MEMBER ROUTES
            int memberId = (int) session.getAttribute("memberId");
            if ("view".equals(action)) {
                int planId = Integer.parseInt(request.getParameter("id"));
                DietPlan plan = fileHandler.getDietPlanById(planId);
                // Security: members can only view their own plans
                if (plan != null && plan.getMemberId() == memberId) {
                    request.setAttribute("plan", plan);
                    request.setAttribute("action", "view");
                }
            }
            request.setAttribute("plans", fileHandler.getDietPlansByMemberId(memberId));
            request.getRequestDispatcher("memberdiet.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("role") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String role = (String) session.getAttribute("role");
        String action = request.getParameter("action");
        String goal = request.getParameter("fitnessGoal");
        String activity = request.getParameter("activityLevel");
        String dietType = request.getParameter("dietType");
        String medical = request.getParameter("medicalCondition");

        // Water intake calculation
        double water = "weight loss".equalsIgnoreCase(goal) ? 3.0
                : "weight gain".equalsIgnoreCase(goal) ? 3.5 : 2.5;
        if ("high".equalsIgnoreCase(activity)) water += 1.0;

        if ("create".equals(action)) {
            int mId;
            String mName;

            if ("admin".equalsIgnoreCase(role)) {
                String memberIdParam = request.getParameter("memberId");
                mId = (memberIdParam != null && !memberIdParam.isEmpty())
                        ? Integer.parseInt(memberIdParam) : 0;
                mName = request.getParameter("memberName") != null
                        ? request.getParameter("memberName") : "Unknown";
            } else {
                mId = (int) session.getAttribute("memberId");
                mName = (String) session.getAttribute("memberName");
            }

            DietPlan plan = new DietPlan(
                    0, mId, mName, dietType, goal, medical, water,
                    DietPlanFileHandler.generatePlanDetails(dietType, goal, activity, medical),
                    java.time.LocalDate.now().toString()
            );
            fileHandler.createDietPlan(plan);

            if ("admin".equalsIgnoreCase(role)) {
                response.sendRedirect("dietplan?action=list&test=admin");
            } else {
                response.sendRedirect("dietplan?action=list&test=member");
            }

        } else if ("update".equals(action) && "admin".equalsIgnoreCase(role)) {
            DietPlan updated = new DietPlan(
                    Integer.parseInt(request.getParameter("planId")),
                    Integer.parseInt(request.getParameter("memberId")),
                    request.getParameter("memberName"),
                    dietType, goal, medical, water,
                    DietPlanFileHandler.generatePlanDetails(dietType, goal, activity, medical),
                    request.getParameter("createdDate")
            );
            fileHandler.updateDietPlan(updated);
            response.sendRedirect("dietplan?action=list&test=admin");

        } else {
            response.sendRedirect("dietplan?action=list");
        }
    }
}