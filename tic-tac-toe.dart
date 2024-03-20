import 'dart:io';

class TicTacToe {
  List<List<String>> _board = List.generate(3, (_) => List.filled(3, " "));
  String _currentPlayer = "X";
  bool _gameEnded = false;

  TicTacToe();

  void printBoard() {
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        stdout.write(_board[i][j]);
        if (j < 2) stdout.write("|");
      }
      print("");
      if (i < 2) print("-----");
    }
  }

  bool isValidMove(int x, int y) {
    if (x < 0 || x > 2 || y < 0 || y > 2) return false;
    if (_board[x][y] != " ") return false;
    return true;
  }

  void makeMove(int x, int y) {
    if (!isValidMove(x, y)) {
      print("Invalid move, try again.");
      return;
    }
    _board[x][y] = _currentPlayer;
    if (checkWin()) {
      print("Player ${_currentPlayer} wins!");
      _gameEnded = true;
      return;
    }
    if (checkDraw()) {
      print("It's a draw!");
      _gameEnded = true;
      return;
    }
    _currentPlayer = _currentPlayer == "X" ? "O" : "X";
  }

  bool checkWin() {
    for (int i = 0; i < 3; i++) {
      if (_board[i].every((e) => e == _currentPlayer)) return true;
      if (_board.map((e) => e[i]).toList().every((e) => e == _currentPlayer))
        return true;
    }
    if ([_board[0][0], _board[1][1], _board[2][2]]
        .every((e) => e == _currentPlayer)) return true;
    if ([_board[0][2], _board[1][1], _board[2][0]]
        .every((e) => e == _currentPlayer)) return true;
    return false;
  }

  bool checkDraw() {
    if (_board.expand((e) => e).any((e) => e == " ")) return false;
    return true;
  }

  void restartGame() {
    _board = List.generate(3, (_) => List.filled(3, " "));
    _currentPlayer = "X";
    _gameEnded = false;
  }
}

void main() {
  TicTacToe game = TicTacToe();
  while (true) {
    print("Tic Tac Toe");
    print("-------------");
    game.printBoard();
    if (game._gameEnded) {
      print("Do you want to restart the game? (y/n)");
      String? input = stdin.readLineSync();
      if (input == null || input.toLowerCase() != "y") break;
      game.restartGame();
    }
    print("Enter the row and column (e.g. 0 0):");
    List<String>? inputs = stdin.readLineSync()?.split(" ");
    if (inputs == null || inputs.length != 2) {
      print("Invalid input, try again.");
      continue;
    }
    int x = int.parse(inputs[0]);
    int y = int.parse(inputs[1]);
    game.makeMove(x, y);
  }
  print("Thanks for playing, good bye!");
}
