<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>

<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset="ISO-8859-1">
        <link rel="stylesheet" href="form.css"/>
        <title>Alterar Chamado</title>
    </head>
    <body>
        <%

            //Recebe o codigo do formulario
            int codigo;
            codigo = Integer.parseInt(request.getParameter("codigo"));

            //Conecta com o banco de dados
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection conecta;
                String url="jdbc:mysql://mysqldb-ghvs.mysql.database.azure.com:3306/bancoaulapi?useSSL=true";
                conecta = DriverManager.getConnection(url, "guilhermehvsroot", "$eN@C3229");

                //Busca no banco de dados
                PreparedStatement stat;
                stat = conecta.prepareStatement("SELECT * FROM chamado WHERE codigo = ? ");
                stat.setInt(1, codigo);
                ResultSet resultado = stat.executeQuery();

                //Verifica se existe o chamado
                if (!resultado.next()) {
                    out.print("<p style='color:red; font-size:30px; font-weight: bold;'>Não existe chamado com esse código</p>");
                } else {
        %>
        <form method="post" action="alterar_chamado.jsp">
            <h3 style="margin-top: 0;">
                Código:
                <input type="number" name="codigo" id="codigo" value="<%= resultado.getString("codigo") %>" readonly>
            </h3>
                <label for="nome">Nome:</label>
                <input type="text" id="nome" name="nome" required size="50" maxlength="50"value="<%=resultado.getString("nome")%>">
            </p>
            <p>
                <label for="setor">Setor da Empresa:</label>
                <select id="setor" name="setor" >
                    <option value="<%=resultado.getString("setor")%>"><%=resultado.getString("setor")%></option>
                    <option value="RH">Recursos Humanos</option>
                    <option value="Financeiro">Financeiro</option>
                    <option value="TI">Tecnologia da Informação</option>
                    <option value="Operacoes">Operações</option>
                    <option value="Marketing">Marketing</option>
                </select>
            </p>
            <p>
                <label for="email">Email:</label>
                <input type="email" id="email" name="email" size="50" maxlength="50" value="<%=resultado.getString("email")%>">
            </p>
            <p>
                <label for="telefone">Telefone:</label>
                <input type="tel" id="telefone" name="telefone" size="50" maxlength="50" value="<%=resultado.getString("telefone")%>">      
            </p>
            <p>
                <label for="mensagem">Mensagem:</label>
                <input type="text" name="mensagem" id="mensagem" required size="200" maxlength="200" value="<%=resultado.getString("mensagem")%>">
            </p>
            <fieldset>
                <legend>Tipo de problema</legend>


                <label for="software"><input type="radio" id="software" name="tipo" value="software" checked />Software</label>


                <label for="hardware"><input type="radio" id="hardware" name="tipo" value="hardware" />Hardware</label>


                <label for="outro"><input type="radio" id="outro" name="tipo" value="outro" />Outro</label>

            </fieldset>
            <p style="margin-bottom: 0;">
                <input type="submit" value="Salvar Alterações" />
            </p>

        </form>

        <%
                }
            } catch (Exception erro) {
                String menErro = erro.getMessage();
                out.print("<p style='color:red; font-size:20px'>Entre em contato com o suporte e informe o erro: " + erro.getMessage() + "</p>");

            }


        %>
    </body>
</html>
