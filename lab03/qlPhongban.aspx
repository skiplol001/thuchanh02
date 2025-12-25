<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="qlPhongban.aspx.cs" Inherits="lab03.qlPhongban" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
    /* Thiết lập Flexbox cho div ngoài để căn giữa các nội dung con (DropDownList và GridView) */
    .content-container {
        display: flex;
        flex-direction: column;
        align-items: center; /* Căn giữa theo chiều ngang */
        width: 100%;
        padding-top: 20px;
    }

    /* Định dạng chung cho bảng GridView */
    .gridview {
        border-collapse: collapse; 
        font-family: Tahoma, sans-serif;
        font-size: 13px;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); /* Thêm bóng nhẹ */
        margin-top: 15px;
    }

    /* Tiêu đề cột */
    .gridview th {
        background-color: #3f607c; /* Màu xanh đậm giống trong ảnh */
        color: white;
        padding: 8px 10px;
        border: 1px solid #1a3c5a;
        white-space: nowrap;
        text-align: center;
    }

    /* Hàng dữ liệu (Row) */
    .gridview td {
        padding: 8px 10px;
        border: 1px solid #CCCCCC;
        text-align: center; /* Căn giữa mặc định */
    }

    /* Căn chỉnh cụ thể cho các ô chứa Họ NV và Tên NV */
    .gridview .align-left {
        text-align: left !important;
    }

    /* Định dạng hàng ở trạng thái Edit (tô màu xám như ảnh) */
    .gridview tr.editing-row {
        background-color: #d1d1d1 !important; /* Màu nền xám cho hàng đang chỉnh sửa */
    }

    /* Định dạng cho DropDownList */
    #DropDownList1 {
        padding: 5px;
        border: 1px solid #ccc;
        border-radius: 4px;
        font-family: Tahoma, sans-serif;
    }
</style>
</head>
<body>
    <form id="form1" runat="server">
        <div style="margin-left: 40px">
            <h2 style="text-align: center">DEMO QUẢN LÝ NHÂN VIÊN</h2>
            <asp:Panel ID="Panel1" runat="server">
                <asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource1" DataTextField="TenPhong" DataValueField="MaPhong" Height="60px" Width="238px" style="text-align: center">
                </asp:DropDownList>
            </asp:Panel>
            <br />

        <asp:GridView ID="GridView1" runat="server" CssClass="gridview"
            DataSourceID="SqlDataSource2"
            AutoGenerateColumns="False"
            AllowPaging="True"
            AllowSorting="True"
            DataKeyNames="MaNV" BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="3" Width="640px">
            
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
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:QLPhongban %>" SelectCommand="SELECT * FROM [Phong]"></asp:SqlDataSource>
            <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:qlNhanvienPhongBan %>" SelectCommand="SELECT * FROM [NhanVien] WHERE ([MaPhong] = @MaPhong)">
                <SelectParameters>
                    <asp:ControlParameter ControlID="DropDownList1" Name="MaPhong" PropertyName="SelectedValue" Type="Int32" />
                </SelectParameters>
            </asp:SqlDataSource>
        </div>
    </form>
</body>
</html>
