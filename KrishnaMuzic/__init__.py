from KrishnaMuzic.core.bot import KRISHNA
from KrishnaMuzic.core.dir import dirr
from KrishnaMuzic.core.git import git
from KrishnaMuzic.core.userbot import Userbot
from KrishnaMuzic.misc import dbb, heroku

from .logging import LOGGER

dirr()
git()
dbb()
heroku()

app = KRISHNA()
userbot = Userbot()


from .platforms import *

Apple = AppleAPI()
Carbon = CarbonAPI()
SoundCloud = SoundAPI()
Spotify = SpotifyAPI()
Resso = RessoAPI()
Telegram = TeleAPI()
YouTube = YouTubeAPI()


