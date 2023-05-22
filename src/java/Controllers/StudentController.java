/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Controllers;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import Models.Data;
import Models.Model;

/**
 *
 * @author HP
 */
@WebServlet(urlPatterns = {"/student"})
public class StudentController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException {
        RequestDispatcher dispatcher = req.getRequestDispatcher("Views/StudentList.jsp");
        dispatcher.forward(req, res);
        //res.sendRedirect("Views/StudentList.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException {
        String _do = req.getParameter("do");
        if ("add".equals(_do)) {
            String id = req.getParameter("id");
            String[] info = {
                req.getParameter("name"),
                req.getParameter("grade"),
                req.getParameter("dob"),
                req.getParameter("address"),
                req.getParameter("notes"),};
            Data.getInstance().StudentList.put(id, info);
            Model model = new Model();
            model.execute(
                    "use JAVA_CoursesDB; INSERT INTO Student VALUES (" + id + ",N\'" + info[0] + "\'," + info[1] + ",\'"
                    + info[2] + "\',N\'" + info[3] + "\',N\'" + info[4] + "\')");
        } else if ("delete".equals(_do)) {
            String id = req.getParameter("id");
            Data.getInstance().StudentList.remove(id);
            Model model = new Model();
            model.execute(
                    "use JAVA_CoursesDB; Delete from Student where Student.id = " + id);

        } else if ("edit".equals(_do)) {
            String id = req.getParameter("id");
            String name = req.getParameter("n");
            String grade = req.getParameter("grade");
            String dob = req.getParameter("birthday");
            String address = req.getParameter("address");
            String note = req.getParameter("note");

            //Data.getInstance().StudentList.remove(id);
            Model model = new Model();
            model.execute(
                    "use JAVA_CoursesDB; update student set " + (" student.name = n\'")
                    + name + "\', student.grade = " + grade + ", student.dob = \'" + dob + "\', student.address = n\'" + address + "\',student.note= n\'" + note
                    + "\' where student.id = \'" + id + "\';");
            Data.getInstance().StudentList.put(id, new Object[]{name, grade, dob, address, note});

        }

//        RequestDispatcher dispatcher = req.getReque   stDispatcher("Views/StudentList.jsp");
//        dispatcher.forward(req, res);
        RequestDispatcher dispatcher = req.getRequestDispatcher("Views/StudentList.jsp");
        dispatcher.forward(req, res);
    }
}
