using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Security.Cryptography;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using System.Text.RegularExpressions;
using System.Drawing;
using System.Configuration;

namespace IT2163_ASSIGNMENT_203417D
{
	public partial class Registration : System.Web.UI.Page
	{
		protected void Page_Load(object sender, EventArgs e)
		{
			

		}

		////////////////////////////////////////////////////////////////////////
		// THE PASSWORD CHECKER
		protected void btn_checkPassword_Click(object sender, EventArgs e)
		{
			Button button = sender as Button;

			int scores = checkPassword(tb_password.Text);
			string status = "";
			switch (scores)
			{
				case 1:
					status = "Very Weak";

					break;
				case 2:
					status = "Weak";
					break;
				case 3:
					status = "Medium";
					break;
				case 4:
					status = "Strong";
					break;
				case 5:
					status = "Very Strong";
					break;
				default:
					break;
			}
			lbl_pwdchecker.Text = "Status : " + status;
			if (scores < 4)
			{
				lbl_pwdchecker.ForeColor = Color.Red;
				return;
			}
			lbl_pwdchecker.ForeColor = Color.Green;
		}

		private int checkPassword(string password)
		{
			int score = 0;

			if (password.Length < 12)
			{
				return 1;
			}
			else
			{
				score = 1;
			}

			if (Regex.IsMatch(password, "[a-z]"))
			{
				score++;
			}

			if (Regex.IsMatch(password, "[A-Z]"))
			{
				score++;
			}

			if (Regex.IsMatch(password, "[0-9]"))
			{
				score++;
			}

			if (Regex.IsMatch(password, "[a-z]"))
			{
				score++;
			}

			if (Regex.IsMatch(password, "/[!@#$%^&*()_+=-`~]/"))
			{
				score++;
			}
			return score;
		}
		// END OFF PASSWORD CHECKER
		////////////////////////////////////////////////////////////////////////
		////////////////////////////////////////////////////////////////////////
		// THE HASHING 

		string MYDBConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["MYDBConnection"].ConnectionString;

		static string finalHash;
		static string salt;
		byte[] Key;
		byte[] IV;
		protected void btn_Submit_Click(object sender, EventArgs e)
		{

			string pwd = tb_password.Text.ToString().Trim();
			RNGCryptoServiceProvider rng = new RNGCryptoServiceProvider();
			byte[] saltByte = new byte[8];

			rng.GetBytes(saltByte);
			salt = Convert.ToBase64String(saltByte);
			SHA512Managed hashing = new SHA512Managed();

			string pwdWithSalt = pwd + salt;
			byte[] plainHash = hashing.ComputeHash(Encoding.UTF8.GetBytes(pwd));
			byte[] hashWithSalt = hashing.ComputeHash(Encoding.UTF8.GetBytes(pwdWithSalt));

			finalHash = Convert.ToBase64String(hashWithSalt);

			RijndaelManaged cipher = new RijndaelManaged();
			cipher.GenerateKey();
			Key = cipher.Key;
			IV = cipher.IV;

			createAccount();


			}

		protected void createAccount()
		{


			try
			{
				using (SqlConnection con = new SqlConnection(MYDBConnectionString))
				{
					SqlCommand check_email = new SqlCommand("SELECT COUNT(*) FROM [Account] WHERE ([email] = @email)", con);
					check_email.Parameters.AddWithValue("@email", email.Text);
					con.Open();

					int UserExist = (int)check_email.ExecuteScalar();
					con.Close();

					if (UserExist > 0)
					{
						lb_error1.Text = "Email already used";

					}
					else
					{
						using (SqlCommand cmd = new SqlCommand("INSERT INTO Account VALUES(@firstname, @lastname, @ccno, @ccexp, @cccvv, @PasswordHash, @dob, @photo, @IV, @Key, @PasswordSalt, @email )"))
						{
							using (SqlDataAdapter sda = new SqlDataAdapter())
							{
								cmd.CommandType = CommandType.Text;
								cmd.Parameters.AddWithValue("@firstname", fname.Text.Trim());
								cmd.Parameters.AddWithValue("@lastname", lname.Text.Trim());
								cmd.Parameters.AddWithValue("@PasswordHash", finalHash);
								cmd.Parameters.AddWithValue("@PasswordSalt", salt);
								cmd.Parameters.AddWithValue("@dob", dob.Text.Trim());
								cmd.Parameters.AddWithValue("@photo", photo.Text.Trim());
								cmd.Parameters.AddWithValue("@email", email.Text.Trim());
								cmd.Parameters.AddWithValue("@ccno", Convert.ToBase64String(encryptData(cc_number.Text.Trim())));
								cmd.Parameters.AddWithValue("@ccexp", Convert.ToBase64String(encryptData(cc_exp.Text.Trim())));
								cmd.Parameters.AddWithValue("@cccvv", Convert.ToBase64String(encryptData(cc_cvv.Text.Trim())));
								cmd.Parameters.AddWithValue("@IV", Convert.ToBase64String(IV));
								cmd.Parameters.AddWithValue("@Key", Convert.ToBase64String(Key));

								cmd.Connection = con;

								try
								{
									con.Open();
									cmd.ExecuteNonQuery();
								}

								catch (Exception ex)
								{
									lb_error1.Text = "There is a problem within the server";
									Response.StatusCode = 500;
								}
								finally
								{
									con.Close();
								}
							}
						}
					}

					

                }
            }
			catch (Exception ex)
			{
				throw new Exception(ex.ToString());
			}
		}

		protected byte[] encryptData(string data)
		{
			byte[] cipherText = null;
			try
			{
				RijndaelManaged cipher = new RijndaelManaged();
				cipher.IV = IV;
				cipher.Key = Key;
				ICryptoTransform encryptTransform = cipher.CreateEncryptor();
				byte[] plainText = Encoding.UTF8.GetBytes(data);
				cipherText = encryptTransform.TransformFinalBlock(plainText, 0, plainText.Length);
			}
			catch (Exception ex)
			{
				throw new Exception(ex.ToString());
			}
			finally { }
			return cipherText;
		}
	}
}