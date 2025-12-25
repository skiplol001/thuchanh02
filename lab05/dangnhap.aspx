<%@ Page Title="ĐĂNG NHẬP" Language="C#" MasterPageFile="~/default.Master" 
    AutoEventWireup="true" CodeBehind="dangnhap.aspx.cs" Inherits="lab05.dangnhap" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .login-container {
            max-width: 400px;
            margin: 0 auto;
            padding: 40px 20px;
        }
        
        .login-title {
            color: #ff4081;
            text-align: center;
            font-size: 28px;
            margin-bottom: 30px;
        }
        
        .login-form {
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.1);
        }
        
        .form-group {
            margin-bottom: 20px;
        }
        
        .form-label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
            color: #333;
        }
        
        .form-input {
            width: 100%;
            padding: 12px 15px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 16px;
            box-sizing: border-box;
        }
        
        .btn-login {
            width: 100%;
            padding: 15px;
            background: linear-gradient(135deg, #ff4081, #ff80ab);
            color: white;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
        }
        
        .error-message {
            color: #f44336;
            text-align: center;
            margin-top: 15px;
            padding: 10px;
            background: #ffebee;
            border-radius: 5px;
            display: none;
        }
        
        .error-message.show {
            display: block;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="login-container">
        <h2 class="login-title"> ĐĂNG NHẬP</h2>
        
        <div class="login-form">
            <div class="form-group">
                <label class="form-label">Tên đăng nhập</label>
                <asp:TextBox ID="txtUsername" runat="server" 
                    CssClass="form-input" 
                    placeholder="admin" />
            </div>
            
            <div class="form-group">
                <label class="form-label">Mật khẩu</label>
                <asp:TextBox ID="txtPassword" runat="server" 
                    TextMode="Password" 
                    CssClass="form-input" 
                    placeholder="admin" />
            </div>
            
            <asp:Button ID="btnLogin" runat="server" 
                Text="Đăng nhập" 
                CssClass="btn-login" 
                OnClick="btnLogin_Click" />
            
            <asp:Label ID="lblMessage" runat="server" 
                CssClass="error-message" 
                Visible="false"></asp:Label>
        </div>
    </div>
</asp:Content>