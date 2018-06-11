<%-- 
    Document   : clienteForm
    Created on : 01/06/2018, 22:07:19
    Author     : ArtVin
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Forever Alone</title>
        <link href="css/jquery-ui.css" rel="stylesheet" type="text/css" media="all" />
        <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
        <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
        <script type="text/javascript" >
            $(function(){
                $("#datepicker").datepicker({dateFormat: 'dd/mm/yy'});
            });

            $(document).ready(function(){
                $( "#uf" ).change(function() {
                  getCidades(false);
                });
            });
            
            function getCidades(preencherPrimeiroForm){
                preencherPrimeiroForm = false;
                var estadoId = $("#uf").val();
                var url = "http://localhost:28313/ForeverAlone/webresources/Ajax/cidade/"+estadoId;
                $.ajax({
                    type : "GET",
                    url : url, // URL da sua Servlet
                    // Parâmetro passado para a Servlet
                    dataType : 'json',
                    success : function(data) {
                        // Se sucesso, limpa e preenche a combo de cidade
                        // alert(JSON.stringify(data));
                        if(!preencherPrimeiroForm){
                            $("#cidade").empty();
                        }
                        $.each(data, function(i, obj) {
                            $("#cidade").append('<option value=' + obj.idCidade + '>' + obj.nome + '</option>');
                        });
                    },
                    error : function(request, textStatus, errorThrown) {
                        alert(request.status + ', Error: ' + request.statusText);
                        // Erro
                    }
                });
            }
        </script>
    </head>
    <body>
        <%@include file="header.jsp"%>
        
        <c:if test="${!(empty loginBean) && loginBean.tipo != 'F' && loginBean.tipo != 'f'}">
            <jsp:forward page="index.jsp">
                <jsp:param name="msg" value="Apenas funcionarios podem cadastrar clientes enquanto estão logados" />
            </jsp:forward>
        </c:if>
        
        <c:if test="${not empty msg}">
            <div class="container alert alert-warning" role="alert">
                <span>${msg}</span>
            </div>
        </c:if>
        
        <div class="login elite-app">
            <div class="container">
                <div class="tittle-agileinfo">
                    <h3>Cadastro</h3>
                </div>
                <div class="col-md-12 login-form-w3-agile">
                <c:choose>
                    <c:when test="${(not empty loginBean)}">
                        <form action="#" method="POST">
                    </c:when>
                    <c:otherwise>
                        <form action="UsuarioServlet?action=cadastroCliente" method="POST">
                    </c:otherwise>
                </c:choose>
                
                    <c:choose>
                        <c:when test="${(not empty loginBean)}">
                            <div class="w3_form_body_grid">
                                <span>Email*</span>
                                <input type="text" name="email" placeholder="Email" value="" required>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="w3_form_body_grid">
                                <span>Email*</span>
                                <input type="text" name="email" placeholder="Email" value="" required>
                            </div>
                        </c:otherwise>
                    </c:choose>

                    <c:choose>
                        <c:when test="${(not empty loginBean)}">
                            <div class="w3_form_body_grid">
                                <span>Senha*</span>
                                <input type="password" name="senha" placeholder="Senha" value="" required>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="w3_form_body_grid">
                                <span>Senha*</span>
                                <input type="password" name="senha" placeholder="Senha" value="" required>
                            </div>
                        </c:otherwise>
                    </c:choose>

                    <c:choose>
                        <c:when test="${(not empty loginBean)}">
                            <div class="w3_form_body_grid">
                                <span>Confirmar senha*</span>
                                <input type="password" name="senhaConfirm" placeholder="Confirmar senha" value="" required>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="w3_form_body_grid">
                                <span>Confirmar senha*</span>
                                <input type="password" name="senhaConfirm" placeholder="Confirmar senha" value="" required>
                            </div>
                        </c:otherwise>
                    </c:choose>

                    <c:choose>
                        <c:when test="${(not empty loginBean)}">
                            <div class="w3_form_body_grid">
                                <span>Nome*</span>
                                <input type="text" name="nome" placeholder="Nome" value="" required>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="w3_form_body_grid">
                                <span>Nome*</span>
                                <input type="text" name="nome" placeholder="Nome" value="" required>
                            </div>
                        </c:otherwise>
                    </c:choose>

                    <c:choose>
                        <c:when test="${(not empty loginBean)}">
                            <div class="w3_form_body_grid">
                                <span>CPF*</span>
                                <input type="text" name="cpf" placeholder="CPF" value="" required>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="w3_form_body_grid">
                                <span>CPF*</span>
                                <input type="text" name="cpf" placeholder="CPF" value="" required>
                            </div>
                        </c:otherwise>
                    </c:choose>

                    <c:choose>
                        <c:when test="${(not empty loginBean)}">
                            <div class="w3_form_body_grid w3_form_body_grid1">
                                <span>Data de nascimento*</span>
                                <input class="date" id="datepicker" name="dataNascimento" type="text" placeholder="dd/mm/yyyy" value="" required>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="w3_form_body_grid w3_form_body_grid1">
                                <span>Data de nascimento*</span>
                                <input class="date" id="datepicker" name="dataNascimento" type="text" placeholder="dd/mm/yyyy" value="" required>
                            </div>
                        </c:otherwise>
                    </c:choose>

                    <c:choose>
                        <c:when test="${(not empty loginBean)}">
                            <div class="w3_form_body_grid">
                                <span>Sexo*</span>
                                <select id="sexo" name="sexo" class="frm-field" required>
                                    <option value="M">Homem</option>
                                    <option value="F">Mulher</option>   						
                                </select>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="w3_form_body_grid">
                                <span>Sexo*</span>
                                <select id="sexo" name="sexo" class="frm-field" required>
                                    <option value="M">Homem</option>
                                    <option value="F">Mulher</option>   						
                                </select>
                            </div>
                        </c:otherwise>
                    </c:choose>

                    <c:choose>
                        <c:when test="${(not empty loginBean)}">
                            <div class="w3_form_body_grid">
                                <span>Estado*</span>
                                <select id="uf" name="uf" class="frm-field" required>
                                    <c:forEach items="${estados}" var="estado">
                                        <c:choose>
                                            <c:when test="${cliente.endereco.cidade.uf.idUF == estado.idUF}">
                                                <option value="${estado.idUF}" selected>${estado.nome} - ${estado.sigla}</option>
                                            </c:when>
                                            <c:otherwise>
                                                <option value="${estado.idUF}">${estado.nome} - ${estado.sigla}</option>
                                            </c:otherwise>
                                         </c:choose>
                                    </c:forEach>  						
                                </select>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="w3_form_body_grid">
                                <span>Estado*</span>
                                <select id="uf" name="uf" class="frm-field" required>
                                    <c:forEach items="${estados}" var="estado">
                                        <c:choose>
                                            <c:when test="${cliente.endereco.cidade.uf.idUF == estado.idUF}">
                                                <option value="${estado.idUF}" selected>${estado.nome} - ${estado.sigla}</option>
                                            </c:when>
                                            <c:otherwise>
                                                <option value="${estado.idUF}">${estado.nome} - ${estado.sigla}</option>
                                            </c:otherwise>
                                         </c:choose>
                                    </c:forEach>  						
                                </select>
                            </div>
                        </c:otherwise>
                    </c:choose>

                    <c:choose>
                        <c:when test="${(not empty loginBean)}">
                            <div class="w3_form_body_grid">
                                <span>Cidade*</span>
                                <select id="cidade" name="cidade" class="frm-field" required>
                                    <option value="${cliente.cidadeCliente.idCidade}" selected>${cliente.cidadeCliente.nomeCidade}</option>						
                                </select>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="w3_form_body_grid">
                                <span>Cidade*</span>
                                <select id="cidade" name="cidade" class="frm-field" required>
                                    <option value="${cliente.cidadeCliente.idCidade}" selected>${cliente.cidadeCliente.nomeCidade}</option>						
                                </select>
                            </div>
                        </c:otherwise>
                    </c:choose>

                    <c:choose>
                        <c:when test="${(not empty loginBean)}">
                            <div class="w3_form_body_grid">
                                <span>Bairro*</span>
                                <input type="text" name="bairro" placeholder="Bairro" value="" required>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="w3_form_body_grid">
                                <span>Bairro*</span>
                                <input type="text" name="bairro" placeholder="Bairro" value="" required>
                            </div>
                        </c:otherwise>
                    </c:choose>

                    <c:choose>
                        <c:when test="${(not empty loginBean)}">
                            <div class="w3_form_body_grid">
                                <span>Rua*</span>
                                <input type="text" name="rua" placeholder="Rua" value="" required>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="w3_form_body_grid">
                                <span>Rua*</span>
                                <input type="text" name="rua" placeholder="Rua" value="" required>
                            </div>
                        </c:otherwise>
                    </c:choose>

                    <c:choose>
                        <c:when test="${(not empty loginBean)}">
                            <div class="w3_form_body_grid">
                                <span>Número*</span>
                                <input type="text" name="numero" placeholder="Número" value="" required>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="w3_form_body_grid">
                                <span>Número*</span>
                                <input type="text" name="numero" placeholder="Número" value="" required>
                            </div>
                        </c:otherwise>
                    </c:choose>

                    <c:choose>
                        <c:when test="${(not empty loginBean)}">
                            <div class="w3_form_body_grid">
                                <span>Complemento</span>
                                <input type="text" name="complemento" placeholder="Complemento" value="">
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="w3_form_body_grid">
                                <span>Complemento</span>
                                <input type="text" name="complemento" placeholder="Complemento" value="">
                            </div>
                        </c:otherwise>
                    </c:choose>

                    <c:choose>
                        <c:when test="${(not empty loginBean)}">
                            <input type="submit" value="Atualizar">
                        </c:when>
                        <c:otherwise>
                            <input type="submit" value="Cadastrar">
                        </c:otherwise>
                    </c:choose>
                    </form>
                </div>
            </div>
        </div>

        <%@include file="footer.jsp"%>
    </body>
</html>
