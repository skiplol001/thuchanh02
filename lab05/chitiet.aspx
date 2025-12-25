<%@ Page Title="CHI TIẾT SÁCH" Language="C#" MasterPageFile="~/default.Master" 
    AutoEventWireup="true" CodeBehind="chitiet.aspx.cs" Inherits="lab05.chitiet" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .chi-tiet-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }
        
        .section-title {
            color: #ff4081;
            font-size: 24px;
            margin: 30px 0 20px 0;
            padding-bottom: 10px;
            border-bottom: 2px solid #ff4081;
        }
        
        .book-detail {
            display: flex;
            gap: 40px;
            margin-bottom: 40px;
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.1);
        }
        
        .book-image-container {
            flex: 0 0 300px;
        }
        
        .book-image-large {
            width: 300px;
            height: 400px;
            object-fit: cover;
            border-radius: 8px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.2);
        }
        
        .book-info {
            flex: 1;
        }
        
        .book-name {
            color: #333;
            font-size: 28px;
            font-weight: bold;
            margin-bottom: 15px;
            line-height: 1.3;
        }
        
        .book-meta {
            margin-bottom: 20px;
        }
        
        .book-meta-item {
            margin-bottom: 10px;
            font-size: 16px;
            color: #555;
        }
        
        .book-meta-label {
            font-weight: bold;
            color: #333;
            display: inline-block;
            width: 120px;
        }
        
        .book-description {
            margin: 25px 0;
            line-height: 1.6;
            color: #444;
            font-size: 15px;
            background: #f9f9f9;
            padding: 20px;
            border-radius: 8px;
            border-left: 4px solid #ff4081;
        }
        
        .book-price-large {
            color: #ff4081;
            font-size: 24px;
            font-weight: bold;
            margin: 20px 0;
        }
        
        .btn-add-cart-large {
            background: linear-gradient(135deg, #ff4081, #ff80ab);
            color: white;
            border: none;
            padding: 15px 30px;
            border-radius: 8px;
            font-size: 18px;
            font-weight: bold;
            cursor: pointer;
            width: 100%;
            max-width: 300px;
            transition: all 0.3s ease;
        }
        
        .btn-add-cart-large:hover {
            background: linear-gradient(135deg, #c2185b, #e91e63);
            transform: translateY(-3px);
            box-shadow: 0 5px 15px rgba(255, 64, 129, 0.4);
        }
        
        .related-books-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
            gap: 25px;
            margin-top: 20px;
        }
        
        .related-book-item {
            background: white;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 3px 10px rgba(0,0,0,0.1);
        }
        
        .related-book-image {
            width: 100%;
            height: 200px;
            object-fit: cover;
        }
        
        .related-book-info {
            padding: 15px;
        }
        
        .related-book-name {
            font-weight: bold;
            color: #333;
            font-size: 16px;
            margin-bottom: 8px;
            height: 45px;
            overflow: hidden;
        }
        
        .related-book-price {
            color: #ff4081;
            font-weight: bold;
            font-size: 16px;
            margin: 10px 0;
        }
        
        .btn-related-detail {
            background: #2196F3;
            color: white;
            border: none;
            padding: 8px 15px;
            border-radius: 5px;
            width: 100%;
            font-size: 14px;
            cursor: pointer;
            margin-top: 10px;
        }
        
        .btn-related-detail:hover {
            background: #0b7dda;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="chi-tiet-container">
        <h2 class="section-title">THÔNG TIN SÁCH</h2>
        
        <asp:FormView ID="FormViewChiTiet" runat="server" DataSourceID="SqlDataSourceChiTiet">
            <ItemTemplate>
                <div class="book-detail">
                    <div class="book-image-container">
                        <asp:Image ID="imgSach" runat="server"
                            ImageUrl='<%# "~/Images/" + (Eval("AnhBia") != DBNull.Value && !string.IsNullOrEmpty(Eval("AnhBia").ToString()) ? Eval("AnhBia") : "no-image.jpg") %>'
                            AlternateText='<%# Eval("TenSach") %>'
                            CssClass="book-image-large" />
                    </div>
                    
                    <div class="book-info">
                        <div class="book-name">
                            <%# Eval("TenSach") %>
                        </div>
                        
                        <div class="book-meta">
                            <div class="book-meta-item">
                                <span class="book-meta-label">Chủ đề:</span>
                                <%# Eval("Tenchude") %>
                            </div>
                            <div class="book-meta-item">
                                <span class="book-meta-label">Nhà xuất bản:</span>
                                <%# Eval("TenNXB") %>
                            </div>
                            <div class="book-meta-item">
                                <span class="book-meta-label">Ngày cập nhật:</span>
                                <%# Convert.ToDateTime(Eval("Ngaycapnhat")).ToString("dd/MM/yyyy") %>
                            </div>
                        </div>
                        
                        <div class="book-price-large">
                            <%# string.Format("{0:#,##0} VNĐ", Eval("Dongia")) %>
                        </div>
                        
                        <div class="book-description">
                            <%# Eval("Mota") != DBNull.Value ? Eval("Mota") : "Không có mô tả" %>
                        </div>
                        
                        <asp:Button ID="btnThemGioHang" runat="server" 
                            Text=" Thêm vào giỏ hàng" 
                            CssClass="btn-add-cart-large" />
                    </div>
                </div>
            </ItemTemplate>
            <EmptyDataTemplate>
                <div style="text-align: center; padding: 50px; color: #666;">
                    Không tìm thấy thông tin sách
                </div>
            </EmptyDataTemplate>
        </asp:FormView>
        
        <div class="related-books">
            <h2 class="section-title">SÁCH CÙNG CHỦ ĐỀ</h2>
            
            <div class="related-books-grid">
                <asp:Repeater ID="rptSachCungChuDe" runat="server" DataSourceID="SqlDataSourceSachCungChuDe">
                    <ItemTemplate>
                        <div class="related-book-item">
                            <asp:Image ID="imgSach" runat="server"
                                ImageUrl='<%# "~/Images/" + (Eval("AnhBia") != DBNull.Value && !string.IsNullOrEmpty(Eval("AnhBia").ToString()) ? Eval("AnhBia") : "no-image.jpg") %>'
                                AlternateText='<%# Eval("TenSach") %>'
                                CssClass="related-book-image" />
                            
                            <div class="related-book-info">
                                <div class="related-book-name">
                                    <%# Eval("TenSach") %>
                                </div>
                                
                                <div class="related-book-price">
                                    <%# string.Format("{0:#,##0} VNĐ", Eval("Dongia")) %>
                                </div>
                                
                                <a href='<%# "chitiet.aspx?MaSach=" + Eval("MaSach") %>' 
                                   class="btn-related-detail" 
                                   style="display: block; text-align: center; text-decoration: none;">
                                    Xem chi tiết
                                </a>
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
                
                <asp:Label ID="lblNoRelated" runat="server" Visible="false">
                    <div style="grid-column: 1 / -1; text-align: center; padding: 40px; color: #666;">
                        Không có sách cùng chủ đề
                    </div>
                </asp:Label>
            </div>
        </div>
        
s        <asp:SqlDataSource ID="SqlDataSourceChiTiet" runat="server" 
            ConnectionString="Data Source=.;Initial Catalog=BookStoreDB;Integrated Security=True"
            SelectCommand="SELECT Sach.*, ChuDe.Tenchude, NhaXuatBan.TenNXB 
                          FROM Sach 
                          INNER JOIN ChuDe ON Sach.MaCD = ChuDe.MaCD 
                          INNER JOIN NhaXuatBan ON Sach.MaNXB = NhaXuatBan.MaNXB 
                          WHERE Sach.MaSach = @MaSach">
            <SelectParameters>
                <asp:QueryStringParameter Name="MaSach" QueryStringField="MaSach" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
        
        <asp:SqlDataSource ID="SqlDataSourceSachCungChuDe" runat="server" 
            ConnectionString="Data Source=.;Initial Catalog=BookStoreDB;Integrated Security=True"
            SelectCommand="SELECT TOP 4 Sach.*, ChuDe.Tenchude 
                          FROM Sach 
                          INNER JOIN ChuDe ON Sach.MaCD = ChuDe.MaCD 
                          WHERE Sach.MaCD = (SELECT MaCD FROM Sach WHERE MaSach = @MaSach) 
                          AND Sach.MaSach != @MaSach
                          ORDER BY NEWID()">
            <SelectParameters>
                <asp:QueryStringParameter Name="MaSach" QueryStringField="MaSach" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
    </div>
</asp:Content>