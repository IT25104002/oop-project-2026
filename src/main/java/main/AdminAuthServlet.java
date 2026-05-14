import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class AdminAuthServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        // அட்மின் லாகின் பக்கத்தில் இருந்து வரும் விவரங்கள்
        String user = request.getParameter("adminUser");
        String pass = request.getParameter("adminPass");

        // இப்போதைக்கு ஒரு சாதாரண Username மற்றும் Password (Elite Gym-க்காக)
        // நீங்கள் விரும்பினால் இதை மாற்றிக்கொள்ளலாம்
        if (user.equals("admin") && pass.equals("elite123")) {
            
            // லாகின் வெற்றி! ஒரு செஷனை (Session) உருவாக்கி அட்மின் டேஷ்போர்டிற்கு அனுப்புகிறோம்
            HttpSession session = request.getSession();
            session.setAttribute("admin", user);
            response.sendRedirect("Admindashboard.jsp");
            
        } else {
            // லாகின் தோல்வி! மீண்டும் லாகின் பக்கத்திற்கே திருப்பி அனுப்புகிறோம்
            response.sendRedirect("AdminLogin.jsp?error=invalid");
        }
    }
}