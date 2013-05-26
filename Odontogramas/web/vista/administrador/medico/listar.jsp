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
    <h2>Listado de  M&eacute;dicos</h2>
    <c:choose>
        <c:when test="${medicos.getRowCount()!= 0}">

            <table class="table table-striped table-bordered table-condensed">
                <thead>
                <th>Identificaci&oacute;n</th>    
                <th>M&eacute;dico</th>
                <th>Acci&oacute;n</th>
                </thead>
                <tbody>
                    <c:forEach items="${medicos.rowsByIndex}" var="row" varStatus="iter">
                        <tr>
                            <td>   
                                <c:out value="${row[0]}"/>
                            </td>
                            <td>   
                                <a href="#listaPacientes&${row[0]}" title="Ver pacientes asociados">${row[1]}</a>
                            </td>
                            <td class="action icon16">
                                <a href="#verMedico&${row[0]}" title="Ver medico"><i class="icon-eye-open"></i></a>
                                <a href="#editarMedico&${row[0]}" title="Editar medico"><i class="icon-pencil"></i></a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:when>
        <c:otherwise>
            No existen m&eacute;dicos registrados en el sistema para este docente.
        </c:otherwise>
    </c:choose>
</div>



