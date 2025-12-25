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
    public partial class trangchu : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
           
        }
        

        protected void rptSach_ItemCommand(object source, RepeaterCommandEventArgs e)
        {

            if (e.CommandName == "ThemGioHang")
            {
                string[] args = e.CommandArgument.ToString().Split('|');
                int maSach = Convert.ToInt32(args[0]);
                decimal donGia = Convert.ToDecimal(args[1]);

                // Thêm vào giỏ hàng (không thông báo)
                ThemVaoCTDatHang(maSach, donGia);
            }
        }

        private void ThemVaoCTDatHang(int maSach, decimal donGia)
        {
            string connectionString = "Data Source=.;Initial Catalog=BookStoreDB;Integrated Security=True";

            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();

                    // Đảm bảo có đơn hàng SoDH = 1
                    KiemTraDonHang(conn);

                    // Thêm hoặc cập nhật
                    string sql = @"
                        IF NOT EXISTS (SELECT * FROM CTDatHang WHERE MaSach = @MaSach AND SoDH = 1)
                        BEGIN
                            INSERT INTO CTDatHang (MaSach, SoDH, Soluong, Dongia, Thanhtien)
                            VALUES (@MaSach, 1, 1, @Dongia, @Dongia)
                        END
                        ELSE
                        BEGIN
                            UPDATE CTDatHang 
                            SET Soluong = Soluong + 1,
                                Thanhtien = (Soluong + 1) * Dongia
                            WHERE MaSach = @MaSach AND SoDH = 1
                        END";

                    using (SqlCommand cmd = new SqlCommand(sql, conn))
                    {
                        cmd.Parameters.AddWithValue("@MaSach", maSach);
                        cmd.Parameters.AddWithValue("@Dongia", donGia);

                        cmd.ExecuteNonQuery();
                    }
                }
            }
            catch (Exception ex)
            {
                // Ghi log lỗi (không hiển thị)
                System.Diagnostics.Debug.WriteLine("Lỗi CTDatHang: " + ex.Message);
            }
        }

        private void KiemTraDonHang(SqlConnection conn)
        {
            try
            {
                string checkSql = "SELECT COUNT(*) FROM DonDatHang WHERE SoDH = 1";
                using (SqlCommand cmd = new SqlCommand(checkSql, conn))
                {
                    int count = Convert.ToInt32(cmd.ExecuteScalar());
                    if (count == 0)
                    {
                        string insertSql = @"
                            INSERT INTO DonDatHang (SoDH, MaKH, NgayDH, Trigia, Dagiao, Ngaygiao)
                            VALUES (1, 2, GETDATE(), 0, 0, NULL)";

                        using (SqlCommand cmdInsert = new SqlCommand(insertSql, conn))
                        {
                            cmdInsert.ExecuteNonQuery();
                        }
                    }
                }
            }
            catch
            {
            }
        }
    }
}