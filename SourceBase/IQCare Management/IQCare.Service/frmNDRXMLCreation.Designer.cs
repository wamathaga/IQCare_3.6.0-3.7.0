namespace IQCare.Service
{
    partial class frmNDRXMLCreation
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.btnGenerateNDRXml = new System.Windows.Forms.Button();
            this.pBar1 = new System.Windows.Forms.ProgressBar();
            this.SuspendLayout();
            // 
            // btnGenerateNDRXml
            // 
            this.btnGenerateNDRXml.Location = new System.Drawing.Point(103, 126);
            this.btnGenerateNDRXml.Name = "btnGenerateNDRXml";
            this.btnGenerateNDRXml.Size = new System.Drawing.Size(206, 23);
            this.btnGenerateNDRXml.TabIndex = 0;
            this.btnGenerateNDRXml.Text = "Generate NDR XML";
            this.btnGenerateNDRXml.UseVisualStyleBackColor = true;
            this.btnGenerateNDRXml.Click += new System.EventHandler(this.btnGenerateNDRXml_Click);
            // 
            // pBar1
            // 
            this.pBar1.Location = new System.Drawing.Point(73, 37);
            this.pBar1.Name = "pBar1";
            this.pBar1.Size = new System.Drawing.Size(299, 23);
            this.pBar1.TabIndex = 1;
            // 
            // frmNDRXMLCreation
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(443, 249);
            this.Controls.Add(this.pBar1);
            this.Controls.Add(this.btnGenerateNDRXml);
            this.Name = "frmNDRXMLCreation";
            this.Text = "frmNDRXMLCreation";
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.Button btnGenerateNDRXml;
        private System.Windows.Forms.ProgressBar pBar1;
    }
}