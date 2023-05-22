/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Models;

import java.sql.*;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author HP
 */
public class Model {
    //
    String user = "sa";
    String password = "1";
    String url = "jdbc:sqlserver://DESKTOP-7DMBUOQ:1434;databaseName=JAVA_CoursesDB;"
            + "trustServerCertificate=true";

    public Model() {
    }

    public void getStudentList(HashMap<String, Object[]> StudentList) throws SQLException {
        Connection conn = null;
        Statement stmt = null;
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            conn = DriverManager.getConnection(url,user,password);
            stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT * FROM Student");
            while (rs.next()) {
                String id = rs.getString("id");
                Object[] info = new Object[]{
                    rs.getString("name"),
                    rs.getString("grade"),
                    rs.getString("dob"),
                    rs.getString("address"),
                    rs.getString("notes")
                };
                StudentList.put(id, info);
            }
            closeConnection(conn, stmt);
            //destroyDriver();
        } catch (SQLException | ClassNotFoundException ex) {
            closeConnection(conn, stmt);
            //destroyDriver();
            Logger.getLogger(Model.class.getName()).log(Level.SEVERE, null, ex);
            return;
        }
    }

    public void getCourseList(HashMap<String, Object[]> CourseList) throws SQLException {
        Connection conn = null;
        Statement stmt = null;
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            conn = DriverManager.getConnection(url,user,password);
            stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT * FROM Course");
            while (rs.next()) {
                String id = rs.getString("id");
                Object[] info = new Object[]{
                    rs.getString("name"),
                    rs.getString("lecture"),
                    rs.getString("_year"),
                    rs.getString("notes")
                };
                CourseList.put(id, info);
            }
            closeConnection(conn, stmt);
            //destroyDriver();
        } catch (SQLException | ClassNotFoundException ex) {
            Logger.getLogger(Model.class.getName()).log(Level.SEVERE, null, ex);
            closeConnection(conn, stmt);
            //destroyDriver();
            return;
        }
    }
    
    public void execute(String query){
        Connection conn = null;
        Statement stmt = null;
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            conn = DriverManager.getConnection(url,user,password);
            stmt = conn.createStatement();
            stmt.executeUpdate(query);
            closeConnection(conn, stmt);
        } catch (SQLException | ClassNotFoundException ex) {
            Logger.getLogger(Model.class.getName()).log(Level.SEVERE, null, ex);
            closeConnection(conn, stmt);
            //destroyDriver();
        }
    }

    public void closeConnection(Connection conn, Statement stmt) {
        try {
            if (stmt != null) {
                stmt.close();
                System.out.println("Statement closed");
            }
            if (conn != null) {
                conn.close();
                System.out.println("Connection closed");
            }
        } catch (SQLException ex) {
            Logger.getLogger(Model.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    
}
