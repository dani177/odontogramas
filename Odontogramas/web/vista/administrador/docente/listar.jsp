<%-- 
    Document   : listar
    Created on : 22/01/2013, 06:55:57 AM
    Author     : jubarcos
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<div class="span9">
    <br/>
    <h2>Listado de  Docentes</h2>
    <c:choose>
        <c:when test="${docentes.getRowCount()!= 0}">

            <table class="table table-striped table-bordered table-condensed">
                <thead>
                <th>id</th>    
                <th>Docente</th>
                <th></th>
                </thead>
                <tbody>
                    <c:forEach items="${docentes.rowsByIndex}" var="row" varStatus="iter">
                        <tr>
                            <td>   
                                <c:out value="${row[0]}"/>
                            </td>
                            <td>   
                                <c:out value="${row[1]}"/>
                            </td>
                            <td class="action icon16">
                                <a href="#verDocente&${row[0]}">Ver</a>
                                <a href="#editarDocente&${row[0]}">Editar</a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:when>
        <c:otherwise>
            No existen docentes registrados en el sistema.
        </c:otherwise>
    </c:choose>
</div>


