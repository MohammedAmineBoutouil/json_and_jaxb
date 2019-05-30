<%-- 
    Document   : testjson
    Created on : May 23, 2019, 9:29:35 PM
    Author     : mohammedamine
--%>
<%@page import="org.eclipse.persistence.jaxb.MarshallerProperties"%>
<%@page import="json.generator.Department"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.io.File"%>
<%@page import="javax.xml.bind.Marshaller"%>
<%@page import="javax.xml.bind.JAXBContext"%>
<%@page import="json.generator.Employees"%>
<%@page import="mesClasses.myConnection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="json.generator.Employee"%>
<%@page import="java.util.List"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <form method="POST">
            <pre>
            <input type="submit" value="export" name="export" />
            </pre>
        </form>
        <%
            if (request.getParameter("export") != null) {
                String href = request.getServletContext().getRealPath("/").replace("/build", "") + "employees.json";
                List<Employee> list = new ArrayList<Employee>();
                try {
                    String sql = "SELECT * FROM EMPLOYEES EMP,DEPARTMENTS DEPT "
                                + "WHERE EMP.DEPARTMENT_ID=DEPT.DEPARTMENT_ID";
                    ResultSet rs = myConnection.getSelect(sql);
                    while (rs.next()) {
                        list.add(new Employee(rs.getInt("EMPLOYEE_ID"),
                                rs.getString("FIRST_NAME"), rs.getString("LAST_NAME"),
                                rs.getString("EMAIL"), rs.getDate("HIRE_DATE"),new Department(rs.getInt("DEPARTMENT_ID"), rs.getString("DEPARTMENT_NAME"))));
                    }
                    rs.close();

                    Employees employees = new Employees();
                    employees.setEmployees(list);

                    JAXBContext context = JAXBContext.newInstance(Employees.class);
                    Marshaller marshaller = context.createMarshaller();

                    marshaller.setProperty(Marshaller.JAXB_FORMATTED_OUTPUT, Boolean.TRUE);
                    
                    //Set JSON type
                    marshaller.setProperty(MarshallerProperties.MEDIA_TYPE, "application/json");
                    marshaller.setProperty(MarshallerProperties.JSON_INCLUDE_ROOT, true);

                    marshaller.marshal(employees, System.out);
                    marshaller.marshal(employees, new File(href));
                    out.println("<a href='employees.json' download=''>Telcharcher</a>");
                } catch (Exception e) {
                    e.printStackTrace();
                }

            }
        %>
    </body>
</html>
