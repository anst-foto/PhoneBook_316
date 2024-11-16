using System.Collections.ObjectModel;
using System.Windows;
using Dapper;
using Microsoft.Data.Sqlite;

namespace PhoneBook_316;

public partial class MainWindow : Window
{
    public ObservableCollection<UserPhone> UserPhones { get; set; } = [];
    
    public MainWindow()
    {
        InitializeComponent();

        Loaded += (_, _) =>
        {
            Dapper.DefaultTypeMap.MatchNamesWithUnderscores = true;
            
            var db = new SqliteConnection("Data Source=phone_book.db");
            db.Open();
            
            const string sql = "SELECT * FROM view_phones";
            var result = db.Query<UserPhone>(sql);

            foreach (var userPhone in result)
            {
                UserPhones.Add(userPhone);
            }
            
            db.Close();
        };
    }
}