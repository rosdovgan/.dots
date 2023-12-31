{ pkgs, ... }: {
  home.packages = with pkgs; [ 
    krusader
    libsForQt5.kget libsForQt5.kompare krename plocate
    p7zip dpkg gzip xz rar gnutar unzip zip
 ];
}
