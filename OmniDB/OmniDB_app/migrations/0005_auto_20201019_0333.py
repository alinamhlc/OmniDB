# Generated by Django 3.0.8 on 2020-10-19 03:33

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('OmniDB_app', '0004_connection_public'),
    ]

    operations = [
        migrations.AlterField(
            model_name='monunitsconnections',
            name='unit',
            field=models.IntegerField(default=None),
        ),
    ]
