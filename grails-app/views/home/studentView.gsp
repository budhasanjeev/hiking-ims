<%--
  Created by IntelliJ IDEA.
  User: Sushant
  Date: 9/19/2016
  Time: 8:08 AM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>User Panel</title>
    <meta content="main" name="layout">
    <link rel="stylesheet" type="text/css" href="${resource(dir: 'css', file: 'bootstrap.min.css')}">
    <script type="text/javascript" src="${resource(dir: 'js',file: 'jquery-1.12.0.min.js')}"></script>
    <script src="${resource(dir: 'js',file: 'student.js')}" type="text/javascript"></script>
    <script src="${resource(dir: 'js',file: 'bootstrap.min.js')}" type="text/javascript"></script>
    <style>
    #main{
        width: 1200px;
        margin: 10% auto;
    }
    li{
        background-color: rgba(205, 196, 191, 0.21)
    }
    button#two:focus
    {
        background:olive;
    }
    </style>
    <script>
        function sendName(){
            var userId = $('#hikerId').val();
            var data = {
                hikerId:userId
            }
            $.ajax({
                url:"${createLink(controller: 'home', action: 'sendName')}",
                type:"POST",
                data:data,
                success: function(resp){
                    console.log(resp)
                    if(resp.messageType=="Successful"){
                        document.getElementById('two').style.backgroundColor='darkblue';
                        document.getElementById('two').disabled = true
                        $('#msg').html("You have submitted your name for hike!!!");
                    }
                } ,error: function (er) {
                    alert("Error")
                }
            })
        }
    </script>
</head>

<body>
<div id="main">
    <div class="container">

        <div class="col-md-5 ">
            <g:hiddenField name="hikerId" id="hikerId" value="${hikerInfo?.id}"/>
            <div class="table-responsive">
                <table class="table">
                    <thead>
                    <tr>
                        <th>Student Information</th>
                        <th></th>

                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                        <td>Name</td>
                        <td>${hikerInfo?.firstName?:''} ${hikerInfo?.middleName?:''} ${hikerInfo?.lastName?:''}</td>
                    </tr>
                    <g:if test="${hikerInfo?.batch}">
                        <tr>
                            <td>Batch</td>
                            <td>${hikerInfo?.batch}</td>

                        </tr>
                        <tr>
                            <td>Roll Number</td>
                            <td>${hikerInfo?.rollNumber}</td>

                        </tr>

                    </g:if>
                    <g:else>
                        <tr>
                            <td>Role</td>
                            <td>Facult/Admin</td>

                        </tr>
                    </g:else>
                    </tbody>
                </table>
            </div>
            <div class="table-responsive">
                <table class="table">
                    <thead>
                    <tr>
                        <th>HIke you have attended</th>
                        <th>${totalCount}</th>

                    </tr>
                    <tr>
                        <td>S.No.</td>
                        <td>Title</td>
                        <td>Date of Hike</td>
                    </tr>
                    </thead>
                    <tbody>
                        <g:if test="${hikeList}">
                            <g:each in="${hikeList}" var="hike" status="i">
                                <tr>
                                    <td>${i+1}</td>
                                    <td>${hike?.title}</td>
                                    <td><g:formatDate format="yyyy-MM-dd" date="${hike?.hikingDate}"/></td>

                                </tr>
                            </g:each>
                        </g:if>
                        <g:else>
                            You haven't attended even a single hike!!!
                        </g:else>
                    </tbody>
                </table>
            </div>
        </div>
        <div class="col-md-1 ">

        </div>
        <div class="col-md-5 ">
        <g:render template="/home/about" model="[hike:hike]"/>
        </div>
</div>

</div>
</body>
</html>