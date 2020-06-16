using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConsoleApp1
{
    delegate void Pronounce();
    delegate void Replace( int index);
    class FieldOfDreams
    {
        char [] Word;
        char[] Scoreboard;
        event Pronounce Done = () => { };
        event Replace Coincidence = x => { };
        public FieldOfDreams(string s)
        {
            Word = s.ToLower().ToArray();
            Scoreboard = new char[Word.Length];
            for (int i = 0; i < Scoreboard.Length; i++)
                Scoreboard[i] = '*';
            Done = delegate 
            {
                Console.WriteLine("The Word is : " + new string(Scoreboard));
                Console.WriteLine("You have won a car !");
            };
                Done += Joke2;
            Coincidence = x => { Scoreboard[x] = Word[x]; };
        }
        public void Play()
        {
            char letter;
            while (true)
            {
                Console.WriteLine("The Word is : "+ new string(Scoreboard));
                Console.WriteLine("Enter a letter : ");
                letter = Char.Parse(Console.ReadLine().ToLower());
                for(int i =0; i< Word.Length; i++)
                {
                    if (letter.Equals(Word[i]))
                    {
                        Coincidence(i);
                    }
                }
                if (new string(Word).Equals(new string(Scoreboard)))
                {
                    Done();
                    break;  
                }  
            }
        }

        void Joke2()
        {
            Console.WriteLine("I do love pickles !");
        }
    }
}
