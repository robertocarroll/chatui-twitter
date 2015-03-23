# Description:
#   Find election candidates
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Command: [not included in help script]
#   election - find election candidates
#
# Author:
#   robertocarroll

# Configures the plugin
module.exports = (robot) ->
	robot.hear /election/i, (msg) ->
		msg.http('http://yournextmp.popit.mysociety.org/api/v0.1/posts/66048?embed=membership.person')
		.get() (error, response, body) ->
			try
		  	candidate_data = JSON.parse(body)
		  	all_members = []
		  	all_members = candidate_data.result.memberships
		  	all_members2015 = []
			  for element, index in all_members
			  	if all_members[index].person_id.standing_in['2015']
			  		if all_members[index].person_id.standing_in['2015'].post_id == '66048'
			  			all_members2015.push all_members[index].person_id
			  	first_member = 	all_members2015[0]	
					msg.send first_member.party_memberships['2015'].name
			catch error
				msg.send "Sorry I can't find any details right now."
           