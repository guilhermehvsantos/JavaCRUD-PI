
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.DriverManager"%>

<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset="ISO-8859-1">
        <link rel="stylesheet" href="styles.css"/>
        <title>JSP Page</title>    
    </head>
    <body>
        <%
            //Recebendo dados do formulário
            String nome, setor, email, telefone, tipo, mensagem;
            nome = request.getParameter("nome");
            setor = request.getParameter("setor");
            email = request.getParameter("email");
            telefone = request.getParameter("telefone");
            tipo = request.getParameter("tipo");
            mensagem = request.getParameter("mensagem");
            
            //Conecta com o banco de dados
            try {
            Connection conecta;
            PreparedStatement stat;
            Class.forName("com.mysql.cj.jdbc.Driver");
            conecta = DriverManager.getConnection("jdbc:mysql://localhost:3306/bancoaulapi","root","$en@c!32");
            
            stat = conecta.prepareStatement("INSERT INTO chamado (nome, setor, email, telefone, mensagem, tipo) VALUES (?, ?, ?, ?, ?, ?)");
            stat.setString(1,nome);
            stat.setString(2,setor);
            stat.setString(3,email);
            stat.setString(4,telefone);
            stat.setString(5,mensagem);
            stat.setString(6,tipo);
            stat.executeUpdate();
            out.print("<p style='color:green; font-size:30px; font-weight: bold;'>Chamado registrado com sucesso</p>");
            } catch (Exception erro) {
            String menErro = erro.getMessage();
            if(menErro.contains("Duplicate entry")) {
                out.print("<p style='color:#1a73e8; font-size:20px font-weight: bold;'>Chamado já foi registrado</p>");
            } else {
            out.print("<p style='color:red; font-size:20px'>Mensagem de erro: " + erro.getMessage() +"</p>");
            }
            }
            %>
    </body>
</html>
