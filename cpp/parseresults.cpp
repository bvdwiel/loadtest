#include <iostream>
#include <string>
#include <sstream>
#include <fstream>
#include <boost/filesystem.hpp>
#include <boost/algorithm/string/predicate.hpp>
#include <boost/lexical_cast.hpp>
#include <boost/tokenizer.hpp>
#include <sqlite3.h>

using namespace std;
using namespace boost;

// Store a line from a C-file in the database
int storeline(vector<string> line, sqlite3* db) {
  string query;
  sqlite3_stmt *stmt;
  query = "INSERT INTO results (PROTO,STATUS,VOLUME,RT,URL,DATETIME,C) VALUES('";
  int counter=0;
  while ( counter <= 5 ) {
    query.append(line[counter]);
    query.append("','");
    counter++;
  }
  query.append("20');");
  sqlite3_prepare_v2(db, query.c_str(), -1, &stmt, NULL);
  sqlite3_step(stmt);
  sqlite3_finalize(stmt);
  return 0;
}

// Initialize the database
int initdb(sqlite3* db) {
  std::ifstream t("ddl.sql");
  sqlite3_stmt  *stmt;
  int rc=0;
  std::string str((std::istreambuf_iterator<char>(t)),std::istreambuf_iterator<char>());
  rc = sqlite3_prepare_v2(db, str.c_str(), -1, &stmt, NULL);
  sqlite3_step(stmt);
  sqlite3_finalize(stmt);
  return 0;
}

int main(int argc, char* argv[])
{
  // Deal with the command line parameter first
  if(argc < 2) {
    std::cerr << "Please provide the concurrency level as a command line argument. Example: parseresult 20" << std::endl;
    return 1;
  }
  // This is a very error-prone way of generating a filename, works for now!
  std::string cfile = "c";
  cfile.append(argv[1]);
  cfile.append(".txt");

  //Can we actually open this file for anything? If not, abort.
  if ( fopen(cfile.c_str(), "r") == NULL ) {
    std::cerr << "Unable to open your c-file, aborting." << std::endl;
    return 1;
  }

  sqlite3* db;
  sqlite3_open("results.db", &db);
  initdb(db);
  ifstream infile(cfile.c_str());
  string line;
  // Wrap the mass of inserts in a single transaction for performance
  sqlite3_exec(db, "BEGIN TRANSACTION", NULL, NULL, NULL); 
  // Process the lines
  while (getline(infile, line)) {
    vector<string> data;
    char_separator<char> sep(", ");
    tokenizer<char_separator<char>> tokens(line, sep);
    for (const auto& t : tokens) {
      data.push_back(t);
    }
    if(data.size() == 8) { //[TODO] Very crude input validation, improve this!!
      storeline(data, db);
    }
  }
  // Finalize the transaction and clean up after yourself
  sqlite3_exec(db, "END TRANSACTION", NULL, NULL, NULL);
  sqlite3_close(db);
}
