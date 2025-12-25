<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="qlNhanvien.aspx.cs" Inherits="lab03.qlNhanvien" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Quản Lý Nhân Viên</title>
   
    <style type="text/css">
    /* Căn giữa bảng */
    .gridview-container {
        display: flex;
        justify-content: center;
        width: 100%;
    }

    .gridview {
        border-collapse: collapse; 
        font-family: Tahoma, sans-serif;
        font-size: 13px;
        width: auto; 
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    }

    .gridview th {
        background-color: #3f607c; 
        color: white;
        padding: 8px 10px;
        border: 1px solid #1a3c5a;
        white-space: nowrap;
    }

    .gridview td {
        padding: 8px 10px;
        border: 1px solid #CCCCCC;
        text-align: center; 
    }

    .gridview tr:nth-child(even) {
        background-color: #f2f2f2;
    }

    .gridview tr:hover {
        background-color: #ddd;
    }

</style>
   
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <h2 style="text-align: center">DEMO QUẢN LÝ NHÂN VIÊN</h2>
            <p>&nbsp;</p>
        </div>

        <asp:SqlDataSource ID="SqlDataSource1" runat="server"
            ConnectionString="<%$ ConnectionStrings:QLNhanVienConnectionString %>"
            
            SelectCommand="SELECT * FROM [NhanVien]"
            
            UpdateCommand="UPDATE [NhanVien] SET [HoNV] = @HoNV, [TenNV] = @TenNV, [Phai] = @Phai, [NgaySinh] = @NgaySinh, [NoiSinh] = @NoiSinh, [MaPhong] = @MaPhong WHERE [MaNV] = @MaNV"
            DeleteCommand="DELETE FROM [NhanVien] WHERE [MaNV] = @MaNV" InsertCommand="INSERT INTO [NhanVien] ([HoNV], [TenNV], [Phai], [NgaySinh], [NoiSinh], [MaPhong]) VALUES (@HoNV, @TenNV, @Phai, @NgaySinh, @NoiSinh, @MaPhong)">
            
            <DeleteParameters>
                <asp:Parameter Name="MaNV" Type="Int32" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="HoNV" Type="String" />
                <asp:Parameter Name="TenNV" Type="String" />
                <asp:Parameter Name="Phai" Type="Boolean" />
                <asp:Parameter DbType="Date" Name="NgaySinh" />
                <asp:Parameter Name="NoiSinh" Type="String" />
                <asp:Parameter Name="MaPhong" Type="Int32" />
            </InsertParameters>
            
            <UpdateParameters>
                <asp:Parameter Name="HoNV" Type="String" />
                <asp:Parameter Name="TenNV" Type="String" />
                <asp:Parameter Name="Phai" Type="Boolean" />
                <asp:Parameter DbType="Date" Name="NgaySinh" />
                <asp:Parameter Name="NoiSinh" Type="String" />
                <asp:Parameter Name="MaPhong" Type="Int32" />
                <asp:Parameter Name="MaNV" Type="Int32" />
            </UpdateParameters>
            
           
        </asp:SqlDataSource>

        <asp:GridView ID="GridView1" runat="server" CssClass="gridview"
            DataSourceID="SqlDataSource2"
            AutoGenerateColumns="False"
            AllowPaging="True"
            AllowSorting="True"
            DataKeyNames="MaNV" BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="3" Width="563px">
            
            <Columns>
                
                <asp:BoundField DataField="MaNV" HeaderText="MaNV" InsertVisible="False" ReadOnly="True" SortExpression="MaNV" />
                <asp:BoundField DataField="HoNV" HeaderText="HoNV" SortExpression="HoNV" />
                <asp:BoundField DataField="TenNV" HeaderText="TenNV" SortExpression="TenNV" />
                <asp:CheckBoxField DataField="Phai" HeaderText="Phai" SortExpression="Phai" />
                <asp:BoundField DataField="NgaySinh" HeaderText="NgaySinh" SortExpression="NgaySinh" />
                <asp:BoundField DataField="NoiSinh" HeaderText="NoiSinh" SortExpression="NoiSinh" />
                <asp:BoundField DataField="MaPhong" HeaderText="MaPhong" SortExpression="MaPhong" />
                <asp:CommandField ShowEditButton="True" />
                
                <asp:CommandField ShowDeleteButton="True" />
                
            </Columns>
            <FooterStyle BackColor="White" ForeColor="#000066" />
            <HeaderStyle BackColor="#006699" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
            <RowStyle ForeColor="#000066" />
            <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
            <SortedAscendingCellStyle BackColor="#F1F1F1" />
            <SortedAscendingHeaderStyle BackColor="#007DBB" />
            <SortedDescendingCellStyle BackColor="#CAC9C9" />
            <SortedDescendingHeaderStyle BackColor="#00547E" />
        </asp:GridView>
        <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:QLNhanVienConnectionString %>" DeleteCommand="DELETE FROM [NhanVien] WHERE [MaNV] = @MaNV" InsertCommand="INSERT INTO [NhanVien] ([HoNV], [TenNV], [Phai], [NgaySinh], [NoiSinh], [MaPhong]) VALUES (@HoNV, @TenNV, @Phai, @NgaySinh, @NoiSinh, @MaPhong)" SelectCommand="SELECT * FROM [NhanVien]" UpdateCommand="UPDATE [NhanVien] SET [HoNV] = @HoNV, [TenNV] = @TenNV, [Phai] = @Phai, [NgaySinh] = @NgaySinh, [NoiSinh] = @NoiSinh, [MaPhong] = @MaPhong WHERE [MaNV] = @MaNV">
            <DeleteParameters>
                <asp:Parameter Name="MaNV" Type="Int32" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="HoNV" Type="String" />
                <asp:Parameter Name="TenNV" Type="String" />
                <asp:Parameter Name="Phai" Type="Boolean" />
                <asp:Parameter DbType="Date" Name="NgaySinh" />
                <asp:Parameter Name="NoiSinh" Type="String" />
                <asp:Parameter Name="MaPhong" Type="Int32" />
            </InsertParameters>
            <UpdateParameters>
                <asp:Parameter Name="HoNV" Type="String" />
                <asp:Parameter Name="TenNV" Type="String" />
                <asp:Parameter Name="Phai" Type="Boolean" />
                <asp:Parameter DbType="Date" Name="NgaySinh" />
                <asp:Parameter Name="NoiSinh" Type="String" />
                <asp:Parameter Name="MaPhong" Type="Int32" />
                <asp:Parameter Name="MaNV" Type="Int32" />
            </UpdateParameters>
        </asp:SqlDataSource>
    </form>
</body>
</html>