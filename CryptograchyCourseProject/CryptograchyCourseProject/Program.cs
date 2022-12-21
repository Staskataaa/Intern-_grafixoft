using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CryptograchyCourseProject
{
    internal class Program
    {
        static void Main(string[] args)
        {
            const int AlphabetSize = 26;
            const int ASCIIToAlphabetStartIndex = 96;
            const int ASCIIToAlphabetEndIndex = 123;

            Console.WriteLine("Insert value for k1: ");
            int k1 = int.Parse(Console.ReadLine());

            Console.WriteLine("Insert value for k1: ");
            int k2 = int.Parse(Console.ReadLine());

            Console.WriteLine("Insert message for encryption: ");
            string message = Console.ReadLine().ToLower();

            byte[] messageArray = Encoding.ASCII.GetBytes(message).Where(c => c > ASCIIToAlphabetStartIndex && c < ASCIIToAlphabetEndIndex).ToArray();

            string encryptedMessage = "";

            for (int i = 0; i < messageArray.Length; i++)
            {
                var letter = messageArray[i] - ASCIIToAlphabetStartIndex;
                var encryptedLetter = (((letter * k1) + k2) % AlphabetSize) + ASCIIToAlphabetStartIndex;
                encryptedMessage += Convert.ToChar(encryptedLetter);
            }

            Console.WriteLine("Encrypted message is: {0}", encryptedMessage);

            Console.WriteLine("Starting decryption...");

            string decryptedMessage = "";

            for (int i = 0; i < encryptedMessage.Length; i++)
            {
                char encryptedLetter = encryptedMessage[i];
                Console.WriteLine("Encrypted letter value is: {0}", encryptedLetter);
                char decryptedLetter = Convert.ToChar(((((byte)encryptedLetter - ASCIIToAlphabetStartIndex - k2) / k1) + ASCIIToAlphabetStartIndex));
                Console.WriteLine("Decrypted letter value is: {0}", decryptedLetter);
                decryptedMessage += decryptedLetter;
            }

            Console.WriteLine("Decrypted message is: {0}", decryptedMessage);

            Console.ReadLine();
        }
    }
}
