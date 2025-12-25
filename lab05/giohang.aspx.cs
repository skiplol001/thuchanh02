using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace lab05
{
    public partial class giohang : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadGioHangTuDatabase();
            }
        }

        private void LoadGioHangTuDatabase()
        {
            DataTable dtGioHang = LayGioHangTuDatabase();

            if (dtGioHang == null || dtGioHang.Rows.Count == 0)
            {
                pnlEmptyCart.Visible = true;
                pnlCartContent.Visible = false;
            }
            else
            {
                pnlEmptyCart.Visible = false;
                pnlCartContent.Visible = true;

                rptCartItems.DataSource = dtGioHang;
                rptCartItems.DataBind();

                // Tính tổng tiền
                decimal tongTien = TinhTongTien(dtGioHang);
                lblTongTien.Text = string.Format("{0:#,##0} VNĐ", tongTien);
            }
        }

        private DataTable LayGioHangTuDatabase()
        {
            DataTable dt = new DataTable();
            string connectionString = "Data Source=.;Initial Catalog=BookStoreDB;Integrated Security=True";

            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();

                    string sql = @"
                        SELECT 
                            CT.MaSach,
                            S.TenSach,
                            CT.Dongia,
                            CT.Soluong,
                            CT.Thanhtien,
                            ISNULL(S.AnhBia, 'no-image.jpg') as HinhAnh
                        FROM CTDatHang CT
                        INNER JOIN Sach S ON CT.MaSach = S.MaSach
                        WHERE CT.SoDH = 1
                        ORDER BY CT.MaSach";

                    using (SqlCommand cmd = new SqlCommand(sql, conn))
                    {
                        using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                        {
                            da.Fill(dt);
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("Lỗi đọc giỏ hàng từ database: " + ex.Message);
                ClientScript.RegisterStartupScript(this.GetType(), "error",
                    $"alert('Lỗi tải giỏ hàng: {ex.Message.Replace("'", "\\'")}');", true);
            }

            return dt;
        }

        private decimal TinhTongTien(DataTable dtGioHang)
        {
            decimal tongTien = 0;
            foreach (DataRow row in dtGioHang.Rows)
            {
                tongTien += Convert.ToDecimal(row["Thanhtien"]);
            }
            return tongTien;
        }

        protected void rptCartItems_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "Update")
            {
                int maSach = Convert.ToInt32(e.CommandArgument);
                TextBox txtQuantity = (TextBox)e.Item.FindControl("txtQuantity");

                if (int.TryParse(txtQuantity.Text, out int soLuong) && soLuong > 0)
                {
                    CapNhatSoLuongDatabase(maSach, soLuong);
                }
            }
            else if (e.CommandName == "Delete")
            {
                int maSach = Convert.ToInt32(e.CommandArgument);
                XoaKhoiGioHangDatabase(maSach);
            }

            LoadGioHangTuDatabase();
        }

        private void CapNhatSoLuongDatabase(int maSach, int soLuong)
        {
            string connectionString = "Data Source=.;Initial Catalog=BookStoreDB;Integrated Security=True";

            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();

                    string sql = @"
                        UPDATE CTDatHang 
                        SET Soluong = @Soluong,
                            Thanhtien = @Soluong * Dongia
                        WHERE MaSach = @MaSach AND SoDH = 1";

                    using (SqlCommand cmd = new SqlCommand(sql, conn))
                    {
                        cmd.Parameters.AddWithValue("@MaSach", maSach);
                        cmd.Parameters.AddWithValue("@Soluong", soLuong);

                        cmd.ExecuteNonQuery();
                    }
                }
            }
            catch (Exception ex)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "error",
                    $"alert('Lỗi cập nhật số lượng: {ex.Message.Replace("'", "\\'")}');", true);
            }
        }

        private void XoaKhoiGioHangDatabase(int maSach)
        {
            string connectionString = "Data Source=.;Initial Catalog=BookStoreDB;Integrated Security=True";

            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();

                    string sql = "DELETE FROM CTDatHang WHERE MaSach = @MaSach AND SoDH = 1";

                    using (SqlCommand cmd = new SqlCommand(sql, conn))
                    {
                        cmd.Parameters.AddWithValue("@MaSach", maSach);

                        int rowsAffected = cmd.ExecuteNonQuery();

                        if (rowsAffected > 0)
                        {
                            ClientScript.RegisterStartupScript(this.GetType(), "success",
                                "alert('Đã xóa sản phẩm khỏi giỏ hàng!');", true);
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "error",
                    $"alert('Lỗi xóa sản phẩm: {ex.Message.Replace("'", "\\'")}');", true);
            }
        }

        protected void btnClearAll_Click(object sender, EventArgs e)
        {
            XoaToanBoGioHang();
            LoadGioHangTuDatabase();
        }

        protected void btnDatHang_Click(object sender, EventArgs e)
        {
            // Xử lý đặt hàng
            XuLyDatHang();
        }

        private void XoaToanBoGioHang()
        {
            string connectionString = "Data Source=.;Initial Catalog=BookStoreDB;Integrated Security=True";

            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();

                    string sql = "DELETE FROM CTDatHang WHERE SoDH = 1";

                    using (SqlCommand cmd = new SqlCommand(sql, conn))
                    {
                        int rowsAffected = cmd.ExecuteNonQuery();

                        ClientScript.RegisterStartupScript(this.GetType(), "success",
                            $"alert('Đã xóa {rowsAffected} sản phẩm khỏi giỏ hàng!');", true);
                    }
                }
            }
            catch (Exception ex)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "error",
                    $"alert('Lỗi xóa giỏ hàng: {ex.Message.Replace("'", "\\'")}');", true);
            }
        }

        private void XuLyDatHang()
        {
            string connectionString = "Data Source=.;Initial Catalog=BookStoreDB;Integrated Security=True";

            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();

                    // Kiểm tra giỏ hàng có sản phẩm không
                    string checkSql = "SELECT COUNT(*) FROM CTDatHang WHERE SoDH = 1";
                    using (SqlCommand cmdCheck = new SqlCommand(checkSql, conn))
                    {
                        int count = Convert.ToInt32(cmdCheck.ExecuteScalar());

                        if (count == 0)
                        {
                            ClientScript.RegisterStartupScript(this.GetType(), "error",
                                "alert('Giỏ hàng trống! Vui lòng thêm sản phẩm vào giỏ hàng trước khi đặt.');", true);
                            return;
                        }
                    }

                    // Cập nhật thông tin đơn hàng
                    string updateSql = @"
                        UPDATE DonDatHang 
                        SET Dagiao = 0,
                            Ngaygiao = NULL,
                            Trigia = (SELECT SUM(Thanhtien) FROM CTDatHang WHERE SoDH = 1)
                        WHERE SoDH = 1";

                    using (SqlCommand cmdUpdate = new SqlCommand(updateSql, conn))
                    {
                        cmdUpdate.ExecuteNonQuery();
                    }

                    // Thông báo thành công
                    ClientScript.RegisterStartupScript(this.GetType(), "success",
                        "alert('Đặt hàng thành công! Đơn hàng của bạn đã được ghi nhận.');", true);

                    // Tạo đơn hàng mới cho lần mua tiếp theo
                    string newOrderSql = @"
                        INSERT INTO DonDatHang (SoDH, MaKH, NgayDH, Trigia, Dagiao, Ngaygiao)
                        VALUES (2, 2, GETDATE(), 0, 0, NULL)";

                    try
                    {
                        using (SqlCommand cmdNew = new SqlCommand(newOrderSql, conn))
                        {
                            cmdNew.ExecuteNonQuery();
                        }
                    }
                    catch
                    {
                        // Bỏ qua nếu đã có SoDH = 2
                    }
                }
            }
            catch (Exception ex)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "error",
                    $"alert('Lỗi đặt hàng: {ex.Message.Replace("'", "\\'")}');", true);
            }
        }
    }
}