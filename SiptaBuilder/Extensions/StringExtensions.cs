using System.Security.Cryptography;
using System.Text;

namespace SiptaBuilder.Extensions
{
	public static class StringExtensions
	{
		public static string CreateSha256(this string input)
		{
			var inputBytes = Encoding.UTF8.GetBytes(input);
			var inputHash = SHA256.HashData(inputBytes);
			return Convert.ToHexString(inputHash);
		}
	}
}