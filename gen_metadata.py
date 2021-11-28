#! /usr/bin/python3
import dropbox

# constants
SRC_PATH = '/website/galleries/familypictures2021/originals'
THUMB_PATH = '/website/galleries/familypictures2021/thumbs'


def get_shared_url(path):
    url = None
    # try to get the link first
    links_metadata = dbx.sharing_list_shared_links(path, direct_only=True)

    if links_metadata and len(links_metadata.links) > 0:
        url = links_metadata.links[0].url
    else:
        link_metadata = dbx.sharing_create_shared_link_with_settings(path)
        url = link_metadata.url

    return url.replace("?dl=0", "?dl=1")


# setup the account information
dbx = dropbox.Dropbox("dQdA-EOc6jAAAAAAAAEAmw8IyHEi8Z2VbqZrFZxZtlcWzcbEPVP5IDRMrsB43HP0")

files = []


# list the files in our target folder
for entry in dbx.files_list_folder(SRC_PATH).entries:
    files.append(entry.name)

files.sort()

for file in files:
    url = get_shared_url(F"{SRC_PATH}/{file}")
    thumb_url = get_shared_url(F"{THUMB_PATH}/{file}")
    print("  - title: ")
    print(F"    image: {url}")
    print(F"    thumbnail: {thumb_url}")
    print("    caption: ")

    
    
    #shared_link_metadata = dbx.sharing_create_shared_link_with_settings(SRC_PATH + '/' + entry.name)
    #print(shared_link_metadata.url)
    # TODO: Do we already have this file?
    #with open(DST_PATH + entry.name, 'wb') as f:
        # _, res = dbx.files_get_thumbnail(SRC_PATH + entry.name, dropbox.files.ThumbnailFormat('jpeg'), size=dropbox.files.ThumbnailSize('w2049h1536'), mode=dropbox.files.ThumbnailMode('strict'))
        # f.write(res.content)


# for each file found, grab the thumbnail