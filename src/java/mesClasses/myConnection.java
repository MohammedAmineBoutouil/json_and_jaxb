/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mesClasses;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

/**
 *
 * @author mohammedamine
 */
public class myConnection {

    public static Connection getConnection() {
        Connection cn = null;
        try {
            Class.forName(YOUR JDBC DRIVER);
            cn = DriverManager.getConnection(URL, USER, PASSWORD);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return cn;
    }

    public static ResultSet getSelect(String sql) {
        ResultSet rs = null;
        try {
            Statement statement = getConnection().createStatement();
            rs = statement.executeQuery(sql);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return rs;
    }

    public static int getUpdate(String sql) {
        int a = 0;
        try {
            Statement statement = getConnection().createStatement();
            a = statement.executeUpdate(sql);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return a;
    }
}
