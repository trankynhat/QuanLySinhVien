<%-- 
    Document   : index
    Created on : Apr 8, 2023, 1:39:13 PM
    Author     : HP
--%>
<%@ page import="Models.Data" %>
<%@ page import="Models.Model" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.util.HashMap" %>


<!DOCTYPE html>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
<script
    src="https://code.jquery.com/jquery-3.6.4.js"
    integrity="sha256-a9jBBRygX1Bh5lt8GZjXDzyOB+bWve9EiO7tROUtj/E="
    crossorigin="anonymous">
</script>
<script type ="text/javascript" >
    function SearchButtonClick() {

        var id = $("#search_input").val();
        $("#SearchModal").modal("show");
        $.ajax({
            url: '/QLSV/CourseData',
            method: 'get',
            data: {id: id},
            success: function (data, textStatus, jqXHR) {
                const info = data.split(",");
                $("#id_search").val(id);
                $("#name_search").val(info[0]);
                $("#lecture_search").val(info[1]);
                $("#year_search").val(info[2]);
                $("#note_search").val(info[3]);
            }
        });
    };
    function Sort(Type) {
        var col = 0;
        if (Type === 1) {
            col = 1;
        } else if (Type === 2) {
            col = 2;
        }
        console.log(col);
        var rows = $('#student_table tbody tr').get();
        rows.sort(function (a, b) {
            var nameA = $(a).children('td').eq(col).text().toUpperCase();
            var nameB = $(b).children('td').eq(col).text().toUpperCase();
            if (nameA < nameB) {
                return -1;
            }
            if (nameA > nameB) {
                return 1;
            }

            return 0;
        });
        $.each(rows, function (index, row) {
            $('#student_table').children('tbody').append(row);
        });
    }

</script>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>FIT@HCMUS</title>
    </head>
    <body class="m-2">
        <div class="d-flex justify-content-center mb-1">
            <h1 class="py-3 px-1", style ="text-align: center ;color: blue" >HCMUS COURSES</h1>


        </div>
        <div class="d-flex justify-content-center mb-1">

            <ul class="nav nav-tabs m-1", style = "text-align: center">
                <li class="nav-item">
                    <a class="nav-link active" aria-current="page" href="/QLSV">Courses</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="/QLSV/student">Students</a>
                </li>
            </ul>

        </div>
        <div class="d-flex justify-content-between mb-1">
            <div>              
                <button type="button" class="btn btn-outline-primary" data-bs-toggle="modal" 
                        data-bs-target="#AddCourseModal">Add</button>
                <button type="button" class="btn btn-outline-primary" data-bs-toggle="modal" 
                        data-bs-target="#DeleteCourseModal">Delete</button>
            </div>

            <div class="input-group" style="width: 300px">
                <input id="search_input" type="text" class="form-control" placeholder="Course's ID" aria-label="Recipient's username" aria-describedby="button-addon2">
                <button id="search_button" class="btn btn-outline-primary" type="button"
                        onclick="SearchButtonClick()">Search</button >
            </div>
        </div>


        <table class="table my-4">
            <thead class="table-primary">
                <tr>
                    <th scope="col">#</th>
                    <th scope="col">ID</th>
                    <th scope="col">Course's Name</th>
                    <th scope="col">Lecture</th>
                    <th scope="col">Year</th>
                    <th scope="col">Notes</th>
                </tr>
            </thead>
            <tbody>
                <% 
                    var data = Data.getInstance().CourseList;
                    int i = 1;
                    for(String id : data.keySet()){ 
                    var info = data.get(id);%>
                <tr>

                    <th scope="row"><%=i%></th>
                    <td><%=id%></td>
                    <td><%=info[0] %></td>
                    <td><%=info[1] %></td>
                    <td><%=info[2] %></td>
                    <td><%=info[3] %></td>
                </tr>
                <% i=i+1;
                    }%>
            </tbody>
        </table>
        <div class="modal fade" id="AddCourseModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h1 class="modal-title fs-5" id="exampleModalLabel">ADD NEW STUDENT</h1>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <form action="/QLSV/course?do=add" method="post">
                            <label for="id" class="form-label">Courses ID</label>
                            <input type="text" name="id" class="form-control" id="id" placeholder="CSC1000000" required>
                            <label for="name" class="form-label mt-3">Course Name</label>
                            <input type="text" name="name" class="form-control" id="name" placeholder="Lap Trinh Ung Dung JAVA" required>
                            <label for="lecture" class="form-label mt-3">Lecture</label>
                            <input type="text" name="lecture" class="form-control" id="lecture" placeholder="Nguyen Van A" required>
                            <label for="year" class="form-label mt-3">Year</label>
                            <input type="text" name="year" class="form-control" id="year" placeholder="2023" required>
                            <label for="notes" class="form-label mt-3">Notes</label>
                            <input type="text" name="notes" class="form-control" id="note" placeholder="">
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" 
                                        data-bs-dismiss="modal" style="width: 80px">Cancel</button>
                                <button type="submit" class="btn btn-primary"
                                        style="width: 80px">Add</button>
                            </div>
                        </form>

                    </div>

                </div>
            </div>
        </div>


        <div class="modal fade" id="DeleteCourseModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h1 class="modal-title fs-5" id="exampleModalLabel">DELETE STUDENT</h1>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <form action="/QLSV/course?do=delete" method="post">
                            <label for="id" class="form-label">ID</label>
                            <input type="text" name="id" class="form-control" id="id" placeholder="CSC100000" required>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" 
                                        data-bs-dismiss="modal" style="width: 80px">Cancel</button>
                                <button type="submit" class="btn btn-primary"
                                        style="width: 80px">DELETE</button>
                            </div>
                        </form>

                    </div>

                </div>
            </div>
        </div>

        <div class="modal fade" id="SearchModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h1 class="modal-title fs-5" id="exampleModalLabel">Course Information</h1>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <form action="/QLSV/course?do=edit" method="post">
                            <label for="id" class="form-label">ID</label>
                            <input type="text" name="id" class="form-control" id="id_search" required>
                            <label for="name" class="form-label">Name</label>
                            <input type="text" name="name" class="form-control" id="name_search"  required>
                            <label for="grade" class="form-label">Lecture</label>
                            <input type="text" name="lecture" class="form-control" id="lecture_search"  required>
                            <label for="birthday" class="form-label">Year</label>
                            <input type="text" name="year" class="form-control" id="year_search"  required>
                            <label for="note" class="form-label">Notes</label>
                            <input type="text" name="note" class="form-control" id="note_search"  required>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" 
                                        data-bs-dismiss="modal" style="width: 80px">Cancel</button>
                                <button type="submit" class="btn btn-primary"
                                        style="width: 80px">Update</button>
                            </div>
                        </form>

                    </div>

                </div>
            </div>
        </div>




        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe" crossorigin="anonymous"></script>

    </body>
</html>
