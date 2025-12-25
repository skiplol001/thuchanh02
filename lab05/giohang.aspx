<%@ Page Title="GIỎ HÀNG" Language="C#" MasterPageFile="~/default.Master"
    AutoEventWireup="true" CodeBehind="giohang.aspx.cs" Inherits="lab05.giohang" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .cart-container {
            max-width: 1200px;
            margin: 0 auto;
        }

        .cart-title {
            color: #ff4081;
            text-align: center;
            font-size: 28px;
            margin-bottom: 30px;
            padding-bottom: 15px;
            border-bottom: 2px solid #ff4081;
        }

        .cart-table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 30px;
            background: white;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 3px 15px rgba(0,0,0,0.1);
        }

            .cart-table th {
                background: #ff4081;
                color: white;
                padding: 15px;
                text-align: center;
                font-weight: 600;
                font-size: 16px;
            }

            .cart-table td {
                padding: 15px;
                text-align: center;
                border-bottom: 1px solid #eee;
                vertical-align: middle;
            }

            .cart-table tr:hover {
                background: #fff0f6;
            }

        .product-image {
            width: 80px;
            height: 100px;
            object-fit: cover;
            border-radius: 5px;
            border: 1px solid #eee;
        }

        .product-name {
            font-weight: bold;
            color: #333;
            font-size: 16px;
            text-align: left;
        }

        .quantity-input {
            width: 60px;
            padding: 8px;
            text-align: center;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 14px;
        }

        .price {
            color: #ff4081;
            font-weight: bold;
            font-size: 16px;
        }

        .total-price {
            color: #2196F3;
            font-weight: bold;
            font-size: 16px;
        }

        .btn-action {
            padding: 8px 15px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 14px;
            transition: all 0.3s ease;
        }

        .btn-update {
            background: #4CAF50;
            color: white;
            margin-right: 5px;
        }

            .btn-update:hover {
                background: #45a049;
                transform: translateY(-2px);
            }

        .btn-delete {
            background: #f44336;
            color: white;
        }

            .btn-delete:hover {
                background: #d32f2f;
                transform: translateY(-2px);
            }

        .cart-summary {
            background: #f9f9f9;
            padding: 20px;
            border-radius: 8px;
            margin-bottom: 30px;
            text-align: right;
            border-left: 4px solid #ff4081;
        }

        .total-label {
            font-size: 18px;
            font-weight: bold;
            color: #333;
        }

        .total-amount {
            color: #ff4081;
            font-size: 24px;
            font-weight: bold;
            margin-left: 10px;
        }

        .cart-actions {
            text-align: center;
            margin-top: 30px;
        }

        .btn-cart-action {
            padding: 15px 30px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-size: 16px;
            font-weight: bold;
            transition: all 0.3s ease;
            margin: 0 10px;
            min-width: 150px;
        }

        .btn-clear {
            background: #f44336;
            color: white;
        }

            .btn-clear:hover {
                background: #d32f2f;
                transform: translateY(-3px);
                box-shadow: 0 5px 15px rgba(244, 67, 54, 0.4);
            }

        .btn-order {
            background: linear-gradient(135deg, #4CAF50, #45a049);
            color: white;
        }

            .btn-order:hover {
                background: linear-gradient(135deg, #45a049, #388E3C);
                transform: translateY(-3px);
                box-shadow: 0 5px 15px rgba(76, 175, 80, 0.4);
            }

        .empty-cart {
            text-align: center;
            padding: 60px;
            color: #666;
            font-size: 18px;
            background: #f9f9f9;
            border-radius: 8px;
            margin: 20px 0;
        }

        .empty-cart-icon {
            font-size: 48px;
            margin-bottom: 20px;
            color: #ccc;
        }

        .back-to-shop {
            display: inline-block;
            margin-top: 20px;
            color: #ff4081;
            text-decoration: none;
            font-weight: 600;
            padding: 10px 20px;
            border: 2px solid #ff4081;
            border-radius: 25px;
            transition: all 0.3s ease;
        }

            .back-to-shop:hover {
                background: #ff4081;
                color: white;
                text-decoration: none;
            }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="cart-container">
        <h1 class="cart-title">GIỎ HÀNG CỦA BẠN</h1>

        <asp:Panel ID="pnlEmptyCart" runat="server" Visible="true">
            <div class="empty-cart">
                <div class="empty-cart-icon"></div>
                <h3>Giỏ hàng của bạn đang trống</h3>
                <p>Hãy thêm sách vào giỏ hàng để tiếp tục mua sắm!</p>
                <asp:HyperLink ID="lnkBackToShop" runat="server"
                    NavigateUrl="~/trangchu.aspx"
                    CssClass="back-to-shop">
                    ← Quay lại mua sắm
                </asp:HyperLink>
            </div>
        </asp:Panel>

        <asp:Panel ID="pnlCartContent" runat="server" Visible="false">
            <table class="cart-table">
                <thead>
                    <tr>
                        <th>Hình ảnh</th>
                        <th>Tên sản phẩm</th>
                        <th>Số lượng</th>
                        <th>Đơn giá</th>
                        <th>Thành tiền</th>
                        <th>Thao tác</th>
                    </tr>
                </thead>
                <tbody>
                    <asp:Repeater ID="rptCartItems" runat="server" OnItemCommand="rptCartItems_ItemCommand">
                        <ItemTemplate>
                            <tr>
                                <td>
                                    <asp:Image ID="imgProduct" runat="server"
                                        CssClass="product-image"
                                        ImageUrl='<%# "~/Images/" + Eval("HinhAnh") %>'
                                        AlternateText='<%# Eval("TenSach") %>'
                                        onerror="this.src='Images/no-image.jpg'" />
                                </td>
                                <td class="product-name">
                                    <%# Eval("TenSach") %>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtQuantity" runat="server"
                                        Text='<%# Eval("Soluong") %>'
                                        CssClass="quantity-input"
                                        TextMode="Number"
                                        min="1"
                                        max="99" />
                                </td>
                                <td class="price">
                                    <%# string.Format("{0:#,##0} VNĐ", Eval("Dongia")) %>
                                </td>
                                <td class="total-price">
                                    <%# string.Format("{0:#,##0} VNĐ", Eval("Thanhtien")) %>
                                </td>
                                <td>
                                    <asp:Button ID="btnUpdate" runat="server"
                                        Text="Cập nhật"
                                        CssClass="btn-action btn-update"
                                        CommandName="Update"
                                        CommandArgument='<%# Eval("MaSach") %>' />
                                    <asp:Button ID="btnDelete" runat="server"
                                        Text="Xóa"
                                        CssClass="btn-action btn-delete"
                                        CommandName="Delete"
                                        CommandArgument='<%# Eval("MaSach") %>'
                                        OnClientClick="return confirm('Bạn có chắc muốn xóa sách này khỏi giỏ hàng?');" />
                                </td>
                            </tr>
                        </ItemTemplate>
                    </asp:Repeater>
                </tbody>
            </table>

            <div class="cart-summary">
                <span class="total-label">TỔNG CỘNG:</span>
                <span class="total-amount">
                    <asp:Label ID="lblTongTien" runat="server" Text="0 VNĐ"></asp:Label>
                </span>
            </div>

            <div class="cart-actions">
                <asp:Button ID="btnClearAll" runat="server"
                    Text="Xóa tất cả"
                    CssClass="btn-cart-action btn-clear" OnClick="btnClearAll_Click" />

                <asp:Button ID="btnDatHang" runat="server"
                    Text="Đặt hàng"
                    CssClass="btn-cart-action btn-order" OnClick="btnDatHang_Click" />
            </div>
        </asp:Panel>
    </div>
</asp:Content>