/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Controllers;

import Models.Data;
import Models.Model;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author HP
 */
@WebServlet(urlPatterns = {"/", "/course"})
public class CourseController extends HttpServlet {

    public CourseController() {

    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException {
        RequestDispatcher dispatcher = req.getRequestDispatcher("Views/CourseList.jsp");
        dispatcher.forward(req, res);
//res.sendRedirect("Views/CourseList.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException {
        String _do = req.getParameter("do");
        if ("add".equals(_do)) {
            String id = req.getParameter("id");
            String[] info = {
                req.getParameter("name"),
                req.getParameter("lecture"),
                req.getParameter("year"),
                req.getParameter("notes"),};
            Data.getInstance().CourseList.put(id, info);
            Model model = new Model();
            model.execute(
                    "use JAVA_CoursesDB; INSERT INTO course VALUES (\'" + id + "\', N\'" + info[0] + "\', N\'" + info[1] + "\',"
                    + info[2] + ",N\'" + info[3] + "\')");
        } else if ("delete".equals(_do)) {
            String id = req.getParameter("id");
            Data.getInstance().CourseList.remove(id);
            Model model = new Model();
            model.execute(
                    "use JAVA_CoursesDB; Delete from course where Course.id = \'" + id+ "\'");

        } else if ("edit".equals(_do)) {
            String id = req.getParameter("id");
            String name = req.getParameter("name");
            String lecture = req.getParameter("lecture");
            String year = req.getParameter("year");
            String note = req.getParameter("note");

            //Data.getInstance().StudentList.remove(id);
            Model model = new Model();
            model.execute(
                    "use JAVA_CoursesDB; update course set course.name = N\'"
                    + name + "\', courses.lecture = N\'" + lecture + "\', course._year = " + year +  ",student.notes = n\'" + note
                    + "\' where student.id = \'" + id + "\';");
            Data.getInstance().CourseList.put(id, new Object[]{name, lecture, year, note});

        }

//        RequestDispatcher dispatcher = req.getReque   stDispatcher("Views/StudentList.jsp");
//        dispatcher.forward(req, res);
        RequestDispatcher dispatcher = req.getRequestDispatcher("Views/CourseList.jsp");
        dispatcher.forward(req, res);
    }
}


