# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

terraform {
  required_providers {
    spotify = {
      version = "~> 0.2.6"
      source  = "conradludgate/spotify"
    }
  }
}

provider "spotify" {
  api_key = var.spotify_api_key
}

data "spotify_search_track" "by_artist" {
  artist = "Sami Yusuf"
  album  = "Al-Muallim"
}

resource "spotify_playlist" "nasheed_playlist" {
  name        = "Terraform Custom Nasheed_Playlist"
  description = "Maryam created this playlist using Terraform"
  public      = true

  tracks = [
    data.spotify_search_track.by_artist.tracks[0].id,
    data.spotify_search_track.by_artist.tracks[1].id,
    data.spotify_search_track.by_artist.tracks[2].id,
  ]
}

resource "spotify_library_albums" "nasheed_quran_album" {
  albums = [
    data.spotify_album.nasheed_by_maher_zain.id,
    data.spotify_album.recitation_by_sudais.id,
    data.spotify_album.nasheed_by_sami_yusuf.id,
    data.spotify_album.recitation_by_shatri.id,
  ]
}

data "spotify_album" "nasheed_by_maher_zain" {
  url = "https://open.spotify.com/album/6GU6PmAOKYRsYVJTMlcjJr"
}

data "spotify_album" "recitation_by_sudais" {
  spotify_id = "3pEO1wH47Z0EQh7jEWvJIP"
}

data "spotify_album" "nasheed_by_sami_yusuf" {
  url = "https://open.spotify.com/album/3FC9MHaKXqQbPxS1Z1Z3Vy"
}

data "spotify_album" "recitation_by_shatri" {
  spotify_id = "37bDyMFVmCKM3zwWPX6TLO"
}



