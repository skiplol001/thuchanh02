<%@ Page Title="SÁCH THEO CHỦ ĐỀ" Language="C#" MasterPageFile="~/default.Master"
    AutoEventWireup="true" CodeBehind="danhsach.aspx.cs" Inherits="lab05.danhsach" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .sach-container {
            padding: 20px;
            max-width: 1200px;
            margin: 0 auto;
        }

        .page-title {
            color: #ff4081;
            text-align: center;
            font-size: 24px;
            margin-bottom: 20px;
        }

        .books-grid {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
            justify-content: center;
        }

        .book-item {
            width: 30%;
            max-width: 300px;
            border: 1px solid #eee;
            padding: 15px;
            background-color: #fff;
            text-align: center;
            box-sizing: border-box;
        }

        .book-image {
            width: 150px;
            height: 200px;
            object-fit: cover;
            margin-bottom: 10px;
        }

        .book-name {
            font-weight: bold;
            color: #333;
            font-size: 14px;
            margin-bottom: 5px;
            height: 40px;
            overflow: hidden;
        }

        .book-price {
            color: #ff4081;
            font-weight: bold;
            font-size: 16px;
            margin: 10px 0;
        }

        .btn-add-cart {
            background: #ff4081;
            color: white;
            border: none;
            padding: 8px 15px;
            border-radius: 5px;
            width: 48%;
            font-size: 14px;
            margin-right: 2%;
            cursor: pointer;
        }

        .btn-detail {
            background: #2196F3;
            color: white;
            border: none;
            padding: 8px 15px;
            border-radius: 5px;
            width: 48%;
            font-size: 14px;
            margin-left: 2%;
            cursor: pointer;
        }

        .btn-add-cart:hover {
            background: #c2185b;
        }

        .btn-detail:hover {
            background: #0b7dda;
        }

        .button-container {
            display: flex;
            justify-content: space-between;
            margin-top: 10px;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="sach-container">
        <h2 class="page-title">
            <asp:Repeater ID="rptTitle" runat="server" DataSourceID="SqlDataSourceChuDe">
                <ItemTemplate>
                    SÁCH CHỦ ĐỀ: <%# Eval("Tenchude") %>
                </ItemTemplate>

            </asp:Repeater>
        </h2>

        <div class="books-grid">
            <asp:Repeater ID="rptSach" runat="server" DataSourceID="SqlDataSourceSach">
                <ItemTemplate>
                    <div class="book-item">
                        <asp:Image ID="imgSach" runat="server"
                            ImageUrl='<%# "~/Images/" + (Eval("AnhBia") != DBNull.Value && !string.IsNullOrEmpty(Eval("AnhBia").ToString()) ? Eval("AnhBia") : "no-image.jpg") %>'
                            AlternateText='<%# Eval("TenSach") %>'
                            CssClass="book-image" />

                        <div class="book-name">
                            <%# Eval("TenSach") %>
                        </div>

                        <div class="book-price">
                            <%# string.Format("{0:#,##0} VNĐ", Eval("Dongia")) %>
                        </div>

                        <div class="button-container">
                            <asp:Button ID="btnThemgiohang" runat="server"
                                Text="Thêm vào giỏ"
                                CssClass="btn-add-cart" />

                            <a href='<%# "chitiet.aspx?MaSach=" + Eval("MaSach") %>'
                                class="btn-detail"
                                style="display: block; text-align: center; text-decoration: none;">Chi tiết
                            </a>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>

        <!-- SqlDataSource để lấy tên chủ đề -->
        <asp:SqlDataSource ID="SqlDataSourceChuDe" runat="server"
            ConnectionString="Data Source=.;Initial Catalog=BookStoreDB;Integrated Security=True"
            SelectCommand="SELECT Tenchude FROM ChuDe WHERE MaCD = @MaCD">
            <SelectParameters>
                <asp:QueryStringParameter Name="MaCD" QueryStringField="MaCD" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>

        <!-- SqlDataSource để lấy sách -->
        <asp:SqlDataSource ID="SqlDataSourceSach" runat="server"
            ConnectionString="Data Source=.;Initial Catalog=BookStoreDB;Integrated Security=True"
            SelectCommand="SELECT TOP 6 Sach.*, ChuDe.Tenchude 
                          FROM Sach 
                          INNER JOIN ChuDe ON Sach.MaCD = ChuDe.MaCD 
                          WHERE (@MaCD IS NULL OR Sach.MaCD = @MaCD)
                          ORDER BY TenSach">
            <SelectParameters>
                <asp:QueryStringParameter Name="MaCD" QueryStringField="MaCD" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
    </div>
</asp:Content>
