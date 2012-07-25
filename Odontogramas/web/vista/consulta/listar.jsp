<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
        <div class="span9">
            <br/>
            <h2>Listado de Consultas</h2>
            <c:choose>
                <c:when test="${fn:length(listaDeConsulta)!= 0}">

                    <table class="table table-striped table-bordered table-condensed">
                        <thead>
                        <th>Numero  de Consulta</th>    
                        <th></th>
                        </thead>
                        <tbody>
                        <c:forEach items="${listaDeConsulta}" var="row" varStatus="iter">
                            <tr>
                            <td>   
                            <c:out value="${row.iddatosConsulta}"/>
                            </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </c:when>
                <c:otherwise>
                    No existen Consultas para este paciente registradas en el sistema.
                </c:otherwise>
            </c:choose>
        </div>

