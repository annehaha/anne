using System;
using System.Collections.Generic;
using System.Text;

namespace MojaKocka
{
    class User
    {
        private static int id=122;
        private int uid = 0;
        private string name;
        private string user;
        private string pass;

        public int Id
        {
            get { return uid; }
            set { uid = value; }
        }
       

        public string Username
        {
            get { return user; }
            set { user = value; }
        }
        
        public string Pass
        {
            get { return pass; }
            set { pass = value; }
        }

        public User()
        {
            user = name = pass = "";
            id++; uid = id;
        }

        public User(string n,string u,string p)
        {
            user = u; name = n; pass = p;
            id++; uid = id;
        }

        public string Name
        {
            get { return name; }
            set { name = value; }
        }

    }
}
