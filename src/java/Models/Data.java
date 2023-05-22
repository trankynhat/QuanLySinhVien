/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Models;

import Controllers.CourseController;
import java.sql.*;
import java.util.HashMap;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author HP
 */
public class Data {

    public HashMap<String, Object[]> StudentList = null;
    public HashMap<String, Object[]> CourseList = null;
    public Object[][] StudentInCourse = null;

    private static Data instance;

    private Data() {

        Model model = new Model();
        //Student List
        try {
            StudentList = new HashMap<>();
            model.getStudentList(StudentList);
        } catch (SQLException ex) {
            Logger.getLogger(Data.class.getName()).log(Level.SEVERE, null, ex);
        }
        //Course List
        try {
            CourseList = new HashMap<>();
            model.getCourseList(CourseList);
            
        } catch (SQLException ex) {
            //model.closeConnection();
            //model.destroyDriver();
            Logger.getLogger(Data.class.getName()).log(Level.SEVERE, null, ex);
        }

        //model.closeConnection();
        //model.destroyDriver();
    }

    public static synchronized Data getInstance() {
        if (instance == null) {
            instance = new Data();
        }
        return instance;
        
    }
    
}
