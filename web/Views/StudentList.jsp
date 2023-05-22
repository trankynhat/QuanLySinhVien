<%-- 
    Document   : StudentList
    Created on : Apr 8, 2023, 4:40:38 PM
    Author     : HP
--%>
<%@ page import="Models.Data" %>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.util.HashMap" %>
<!DOCTYPE html>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
<script
    src="https://code.jquery.com/jquery-3.6.4.js"
    integrity="sha256-a9jBBRygX1Bh5lt8GZjXDzyOB+bWve9EiO7tROUtj/E="
    crossorigin="anonymous">
</script>

<style>
    .sortbtn{
        background-image: url('/Views/sort.png');
        width: 20px;
        height: 20px;
    };
</style>

<script type ="text/javascript" >
    function SearchButtonClick() {

        var id = $("#search_input").val();
        $("#SearchModal").modal("show");
        $.ajax({
            url: '/QLSV/StudentData',
            method: 'get',
            data: {id: id},
            success: function (data, textStatus, jqXHR) {
                const info = data.split(",");
                $("#id_search").val(id);
                $("#name_search").val(info[0]);
                $("#grade_search").val(info[1]);
                $("#dob_search").val(info[2]);
                $("#address_search").val(info[3]);
                $("#note_search").val(info[4]);
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
    <div class="d-flex justify-content-center mb-1">
        <h1 class="py-3 px-1", style ="text-align: center; color: blue" >HCMUS STUDENTS</h1>


    </div>
    <div class="d-flex justify-content-center mb-1">

        <ul class="nav nav-tabs m-1", style = "text-align: center">
            <li class="nav-item">
                <a class="nav-link " aria-current="page" href="/QLSV">Courses</a>
            </li>
            <li class="nav-item">
                <a class="nav-link active" href="/QLSV/student">Students</a>
            </li>
        </ul>
    </div>
    <div class="my-4">
        <div class="d-flex justify-content-between mb-1">
            <div>              
                <button type="button" class="btn btn-outline-primary" data-bs-toggle="modal" 
                        data-bs-target="#AddStudentModal">Add</button>
                <button type="button" class="btn btn-outline-primary" data-bs-toggle="modal" 
                        data-bs-target="#DeleteStudentModal">Delete</button>
            </div>

            <div class="input-group" style="width: 300px">
                <input id="search_input" type="text" class="form-control" placeholder="Student's ID" aria-label="Recipient's username" aria-describedby="button-addon2">
                <button id="search_button" class="btn btn-outline-primary" type="button"
                        onclick="SearchButtonClick()">Search</button >
            </div>
        </div>
        <table id ="student_table" class="table">
            <thead class="table-primary">
                <tr>
                    <th scope="col">#</th>
                    <th scope="col">ID</th>
                    <th scope="col" >Name <button class="btn" onclick="Sort(1)">👇</button></th>
                    <th scope="col"`>
                        Grade
                        <button class="btn" onclick="Sort(2)">👇</button>
                    </th>
                    <th scope="col">Birthday</th>
                    <th scope="col">Address</th>
                    <th scope="col">Notes</th>
                </tr>
            </thead>
            <tbody>
                <%
                    var data = Data.getInstance().StudentList;
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
                    <td><%=info[4] %></td>
                </tr>
                <% i=i+1;
                    }%>
            </tbody>
        </table>
    </div>

    <div class="modal fade" id="AddStudentModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h1 class="modal-title fs-5" id="exampleModalLabel">ADD NEW STUDENT</h1>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form action="/QLSV/student?do=add" method="post">
                        <label for="id" class="form-label">ID</label>
                        <input type="text" name="id" class="form-control" id="id" placeholder="20120000" required>
                        <label for="name" class="form-label mt-3">Name</label>
                        <input type="text" name="name" class="form-control" id="name" placeholder="Nguyễn Văn A" required>
                        <label for="grade" class="form-label mt-3">Grade</label>
                        <input type="text" name="grade" class="form-control" id="grade" placeholder="6.5" required>
                        <label for="dob" class="form-label mt-3">BirthDay</label>
                        <input type="text" name="dob" class="form-control" id="dob" placeholder="yyyy-mm-dd" required>
                        <label for="address" class="form-label mt-3">Address</label>
                        <input type="text" name="address" class="form-control" id="address" placeholder="" required>
                        <label for="notes" class="form-label mt-3">Notes</label>
                        <input type="text" name="notes" class="form-control" id="notes" placeholder="">
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


    <div class="modal fade" id="DeleteStudentModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h1 class="modal-title fs-5" id="exampleModalLabel">DELETE STUDENT</h1>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form action="/QLSV/student?do=delete" method="post">
                        <label for="id" class="form-label">ID</label>
                        <input type="text" name="id" class="form-control" id="id" placeholder="20120000" required>
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
                    <h1 class="modal-title fs-5" id="exampleModalLabel">Student Information</h1>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form action="/QLSV/student?do=edit" method="post">
                        <label for="id" class="form-label">ID</label>
                        <input type="text" name="id" class="form-control" id="id_search" required>
                        <label for="name" class="form-label">Name</label>
                        <input type="text" name="name" class="form-control" id="name_search"  required>
                        <label for="grade" class="form-label">Grade</label>
                        <input type="text" name="grade" class="form-control" id="grade_search"  required>
                        <label for="birthday" class="form-label">Birthday</label>
                        <input type="text" name="birthday" class="form-control" id="dob_search"  required>
                        <label for="address" class="form-label">Address</label>
                        <input type="text" name="address" class="form-control" id="address_search"  required>
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