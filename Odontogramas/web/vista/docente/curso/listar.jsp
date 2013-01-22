<%-- 
    Document   : listar
    Created on : 21/01/2013, 03:57:27 PM
    Author     : jubarcos
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<div class="span9">
    <br/>
    <h2>Listado de  Cursos</h2>
    <c:choose>
        <c:when test="${cursos.getRowCount()!= 0}">

            <table class="table table-striped table-bordered table-condensed">
                <thead>
                <th>id</th>    
                <th>Curso</th>
                <th></th>
                </thead>
                <tbody>
                    <c:forEach items="${cursos.rowsByIndex}" var="row" varStatus="iter">
                        <tr>
                            <td>   
                                <c:out value="${row[2]}"/>
                            </td>
                            <td>   
                                <c:out value="${row[3]}"/>
                            </td>
                            <td class="action icon16">
                                <a href="#verConsulta&${row[0]}">Ver</a>
                                <a href="#editarConsulta&${row[0]}">Editar</a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:when>
        <c:otherwise>
            No existen cursos para este docente registrados en el sistema.
        </c:otherwise>
    </c:choose>
</div>



